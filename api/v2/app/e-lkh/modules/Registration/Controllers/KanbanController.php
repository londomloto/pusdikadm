<?php
namespace App\Registration\Controllers;

use App\Registration\Models\Task;
use App\Registration\Models\TaskStatus;
use App\Registration\Models\TaskLabel;
use App\Projects\Models\Project;
use App\Activities\Models\Activity;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $auth = $this->auth->user();
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;
        
        $columns = array(
            'task_status.tus_id',
            'task_status.tus_su_id',
            'task_status.tus_status',
            'task_status.tus_target',
            'task_status.tus_worker',
            'task_status.tus_deleted',
            'task_status.tus_created'
        );

        $query = TaskStatus::get()
            ->alias('task_status')
            ->columns($columns) 
            ->join('App\Registration\Models\Task', 'task_status.tus_su_id = task.su_id', 'task')
            ->join('App\Registration\Models\TaskLabel', 'task.su_id = task_label.tul_su_id', 'task_label', 'left')
            ->join('App\Registration\Models\TaskUser', 'task.su_id = task_user.tru_task', 'task_user', 'left')
            ->join('App\Labels\Models\Label', 'task_label.tul_sl_id = label.sl_id', 'label', 'left')
            ->join('App\Users\Models\User', 'task.su_created_by = creator.su_id', 'creator', 'left')
            ->groupBy('task_status.tus_id');

        $query->inWhere('task_user.tru_user', array($auth['su_id']));

        if ($project) {
            $query->andWhere('task.su_task_project = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('task_status.tus_status', $statuses);
        }

        $query->andWhere('task_status.tus_deleted = 0');

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        $result = $query->paginate()
            ->filter(function($stat) {
                
                $task = Task::findFirst($stat->tus_su_id);
                $stat = $stat->toArray();

                $item = array();
                $item['task'] = NULL;
                $item['status'] = $stat;
                $item['labels'] = array();
                $item['users'] = array();
                $item['perms'] = array();
                
                if ($task) {
                    $item['task'] = $task->toArray();
                    $item['labels'] = $task->labels->filter(function($label){ return $label->toArray(); });
                    $item['users'] = $task->getAssignee();
                }

                return $item;
                
            });

        return $result;
        
    }

    public function createAction() {
        $post = $this->request->getJson();
        $auth = $this->auth->user();

        if (self::validRequest($post)) {
            $worker = $this->bpmn->worker($post['worker']);

            if ($worker) {
                $task = new Task();
                $form = $post['record'];

                if (empty($form['task']['su_task_due'])) {
                    $today = new \DateTime();
                    $today->modify('+1 day');
                    $form['task']['su_task_due'] = $today->format('Y-m-d');
                }

                $form['task']['su_created_by'] = $auth['su_id'];
                $form['task']['su_created_dt'] = date('Y-m-d H:i:s');
                $form['task']['su_updated_by'] = $form['task']['su_created_by'];
                $form['task']['su_updated_dt'] = $form['task']['su_created_dt'];

                // set password if any
                if (isset($form['task']['su_passwd']) && ! empty($form['task']['su_passwd'])) {
                    $form['task']['su_passwd'] = $this->security->createHash($form['task']['su_passwd']);
                }

                if ($task->save($form['task'])) {

                    if (isset($form['labels'])) {
                        $task->saveLabels($form['labels']);
                    }

                    if (isset($form['users'])) {
                        $task->saveUsers($form['users']);
                    }

                    $affected = array();
                    $init = $worker->start($form['task']);

                    if ($init['data']) {
                        $status = new TaskStatus();

                        $create = array(
                            'tus_su_id' => $task->su_id,
                            'tus_status' => $init['data']['id'],
                            'tus_target' => $init['data']['target'],
                            'tus_worker' => $worker->name(),
                            'tus_deleted' => 0,
                            'tus_created' => date('Y-m-d H:i:s')
                        );

                        if ($status->save($create)) {
                            $affected[] = $status->tus_status;
                        }
                        
                    }

                    $affected = array_values(array_unique($affected));

                    return array(
                        'success' => TRUE,
                        'data' => array(
                            'affected' => $affected,
                            'task' => $task->toArray()
                        )
                    );
                }

            }
        }

        return array(
            'success' => FALSE
        );
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $send = isset($post['send']) ? $post['send'] : FALSE;
        $logs = isset($post['logs']) ? $post['logs'] : TRUE;

        if (self::validRequest($post)) {

            $task = Task::findFirst($id);
            $form = $post['record'];

            $auth = $this->auth->user();

            $form['task']['su_updated_dt'] = date('Y-m-d H:i:s');
            $form['task']['su_updated_by'] = $auth['su_id'];

            if (empty($form['task']['su_task_due'])) {
                $form['task']['su_task_due'] = NULL;
            }

            // set password if any
            if (isset($form['task']['su_passwd']) && ! empty($form['task']['su_passwd'])) {
                $form['task']['su_passwd'] = $this->security->createHash($form['task']['su_passwd']);
            }

            $affected = array();

            if (FALSE === $logs || $send) {
                $task->suspendLog();
            }

            if ($task->save($form['task'])) {

                if (isset($form['labels'])) {
                    $task->saveLabels($form['labels']);
                }

                if (isset($form['users'])) {
                    $task->saveUsers($form['users']);
                }

                $task->resumeLog();

                if ($send) {
                    $move = array();
                    $curr = $task->getCurrentStatuses();

                    $worker = $this->bpmn->worker($post['worker']);
                    $change = array();

                    foreach($curr as $c) {
                        $next = $worker->next($c->tus_status, $form['task']);
                        
                        $affected[] = $c->tus_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->andWhere('tus_su_id = :id: AND tus_deleted = 0', array('id' => $task->su_id))
                                ->inWhere('tus_status', $nextids)
                                ->execute()
                                ->delete();
                            
                            foreach($next['data'] as $n) {

                                $affected[] = $n['id'];

                                $found = TaskStatus::findFirst(array(
                                    'tus_su_id = :id: AND tus_status = :status: AND tus_deleted = 0',
                                    'bind' => array(
                                        'id' => $task->su_id,
                                        'status' => $n['id']
                                    )
                                ));

                                if ( ! $found) {
                                    $status = new TaskStatus();

                                    $create = array(
                                        'tus_su_id' => $task->su_id,
                                        'tus_status' => $n['id'],
                                        'tus_target' => $n['target'],
                                        'tus_worker' => $worker->name(),
                                        'tus_deleted' => 0,
                                        'tus_created' => date('Y-m-d H:i:s')
                                    );
                                    
                                    if ($status->save($create)) {
                                        $status   = $status->refresh();
                                        $change[] = $status->getLabel();

                                        $move[] = $c;
                                    }
                                } else {
                                    // $move[] = $c;
                                }
                            }
                        }

                    }

                    if (count($change) > 0) {
                        $log = Activity::log('update_status', array(
                            'ta_task_ns' => $task->getScope(),
                            'ta_task_id' => $task->su_id,
                            'ta_sp_id' => $task->su_task_project,
                            'ta_data' => json_encode($change)
                        ));

                        if ($log) {
                            $log->subscribe();
                            $log->broadcast();
                        }
                    }

                    // nothing changed
                    if (count($move) > 0) {
                        foreach($move as $m) {
                            $m->save(array('tus_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $affected[] = $c->tus_status;                 
                    }
                }
            }

            $affected = array_values(array_unique($affected));

            return array(
                'success' => TRUE,
                'data' => array(
                    'affected' => $affected,
                    'task' => $task->toArray()
                )
            ); 
        }

        return array(
            'success' => FALSE
        );

    }

    public function deleteAction($id) {
        $task = Task::get($id)->data;
        $done = FALSE;

        if ($task) {
            $done = $task->delete();
        }

        return array(
            'success' => $done
        );
    }

    public static function validRequest($post) {
        return isset(
            $post['worker'],
            $post['record'],
            $post['record']['task'],
            $post['record']['status']
        );
    }

    public static function applySearch($query, $params) {
        if (isset($params['query'], $params['fields']) && $params['query'] != '') {
            $search = strtoupper($params['query']);
            $fields = json_decode($params['fields'], TRUE);
            
            $maps = array(
                'user' => 'task.su_fullname',
                'card' => 'task.su_no',
                'sex' => 'task.su_sex',
                'label' => 'label.sl_label',
                'email' => 'task.su_email'
            );

            $where = array();
            $bind = array();

            foreach($fields as $name) {
                $field = $maps[$name];
                $token = "search_{$name}";
                $where[] = "UPPER($field) LIKE :$token:";
                $bind[$token] = "%".strtoupper($search)."%";
            }

            if (count($where) > 0) {
                $where = '('. implode(' OR ', $where). ')';
                $query->andWhere($where, $bind);
            }
        }
    }

    public static function applyFilter($query, $params) {
        if (isset($params['params'])) {
            $json = json_decode($params['params']);
            
            if (isset($json->tus_id)) {
                $query->andWhere('(task_status.tus_id = :tus_id:)', array('tus_id' => $json->tus_id));
            } else {
                if (isset($json->user) && count($json->user) > 0) {
                    $query->inWhere('task.su_id', $json->user[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('task_label.tul_sl_id', $json->label[1]);
                }
            }
        }
    }

    public static function applySorter($query, $params, $cols) {
        if ( ! isset($params['sort'])) {
            $cols[] = 'MAX(task.su_created_dt) AS su_created_dt';
            $query->columns($cols);
            $query->orderBy('su_created_dt DESC');
        } else {
            $ps = json_decode($params['sort']);

            $sort = array();

            $maps = array(
                'name' => 'task.su_fullname',
                'card' => 'task.su_no',
                'email' => 'task.su_email'
            );

            foreach($ps as $e) {
                $dirs = $e->direction;
                $aggr = strtoupper($dirs) == 'ASC' ? 'MIN' : 'MAX';

                if (isset($maps[$e->property])) {
                    $name = $maps[$e->property];
                    $prop = str_replace('.', '_', $name);
                    $sort[] = $prop.' '.$dirs;
                    $cols[] = $aggr.'('.$name.') AS '.$prop;
                } else if ($e->property == 'created') {
                    $sort[] = 'su_created_dt '.$dirs;
                    $cols[] = $aggr.'(task.su_created_dt) AS su_created_dt';
                }
            }

            if (count($sort) > 0) {
                $sort = implode(', ', $sort);

                $query->columns($cols);
                $query->orderBy($sort);
            }
        }
    }

}