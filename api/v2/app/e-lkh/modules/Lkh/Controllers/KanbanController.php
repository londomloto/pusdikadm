<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\Task;
use App\Lkh\Models\TaskStatus;
use App\Lkh\Models\TaskLabel;
use App\Projects\Models\Project;
use App\Activities\Models\Activity;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $auth = $this->auth->user();
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;
        
        $columns = array(
            'task_status.lks_id',
            'task_status.lks_lkh_id',
            'task_status.lks_status',
            'task_status.lks_target',
            'task_status.lks_worker',
            'task_status.lks_deleted',
            'task_status.lks_created'
        );

        $query = TaskStatus::get()
            ->alias('task_status')
            ->columns($columns) 
            ->join('App\Lkh\Models\Task', 'task_status.lks_lkh_id = task.lkh_id', 'task')
            ->join('App\Lkh\Models\TaskLabel', 'task.lkh_id = task_label.lkl_lkh_id', 'task_label', 'left')
            ->join('App\Lkh\Models\TaskUser', 'task.lkh_id = task_user.lku_lkh_id', 'task_user', 'left')
            ->join('App\Labels\Models\Label', 'task_label.lkl_sl_id = label.sl_id', 'label', 'left')
            ->join('App\Users\Models\User', 'task.lkh_su_id = user.su_id', 'user', 'left')
            ->groupBy('task_status.lks_id');

        $query->inWhere('task_user.lku_su_id', array($auth['su_id']));
        
        if ($project) {
            $query->andWhere('task.lkh_task_project = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('task_status.lks_status', $statuses);
        }

        $query->andWhere('task_status.lks_deleted = 0');

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        //print_r($query->getBuilder()->getQuery()->getSql());

        $result = $query->paginate()
            ->filter(function($stat) {
                
                $task = Task::findFirst($stat->lks_lkh_id);
                $stat = $stat->toArray();

                $item = array();
                $item['task'] = NULL;
                $item['status'] = $stat;
                $item['labels'] = array();
                $item['items'] = array();
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

                if (empty($form['task']['lkh_task_due'])) {
                    $today = new \DateTime();
                    $today->modify('+1 day');
                    $form['task']['lkh_task_due'] = $today->format('Y-m-d');
                }

                $form['task']['lkh_created_by'] = $auth['su_id'];
                $form['task']['lkh_created_dt'] = date('Y-m-d H:i:s');
                $form['task']['lkh_updated_by'] = $form['task']['lkh_created_by'];
                $form['task']['lkh_updated_dt'] = $form['task']['lkh_created_dt'];

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
                            'lks_lkh_id' => $task->lkh_id,
                            'lks_status' => $init['data']['id'],
                            'lks_target' => $init['data']['target'],
                            'lks_worker' => $worker->name(),
                            'lks_deleted' => 0,
                            'lks_created' => date('Y-m-d H:i:s')
                        );

                        if ($status->save($create)) {
                            $affected[] = $status->lks_status;
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

            $form['task']['lkh_updated_dt'] = date('Y-m-d H:i:s');
            $form['task']['lkh_updated_by'] = $auth['su_id'];

            if (empty($form['task']['lkh_task_due'])) {
                $form['task']['lkh_task_due'] = NULL;
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
                        $next = $worker->next($c->lks_status, $form['task']);
                        
                        $affected[] = $c->lks_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->andWhere('lks_lkh_id = :id: AND lks_deleted = 0', array('id' => $task->lkh_id))
                                ->inWhere('lks_status', $nextids)
                                ->execute()
                                ->delete();
                            
                            foreach($next['data'] as $n) {

                                $affected[] = $n['id'];

                                $found = TaskStatus::findFirst(array(
                                    'lks_lkh_id = :id: AND lks_status = :status: AND lks_deleted = 0',
                                    'bind' => array(
                                        'id' => $task->lkh_id,
                                        'status' => $n['id']
                                    )
                                ));

                                if ( ! $found) {
                                    $status = new TaskStatus();

                                    $create = array(
                                        'lks_lkh_id' => $task->lkh_id,
                                        'lks_status' => $n['id'],
                                        'lks_target' => $n['target'],
                                        'lks_worker' => $worker->name(),
                                        'lks_deleted' => 0,
                                        'lks_created' => date('Y-m-d H:i:s')
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
                            'ta_task_id' => $task->lkh_id,
                            'ta_sp_id' => $task->lkh_task_project,
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
                            $m->save(array('lks_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $affected[] = $c->lks_status;                 
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
                'user' => 'user.su_fullname',
                'date' => 'task.lkh_start_date',
                'label' => 'label.sl_label',
                'period' => 'task.lkh_period',
                'identity' => 'user.su_no'
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
            
            if (isset($json->lks_id)) {
                $query->andWhere('(task_status.lks_id = :lks_id:)', array('lks_id' => $json->lks_id));
            } else {
                if (isset($json->user) && count($json->user) > 0) {
                    $query->inWhere('user.su_id', $json->user[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('task_label.lkl_sl_id', $json->label[1]);
                }

                if (isset($json->date) && count($json->date) > 0) {
                    $dates = isset($json->date[1]) ? $json->date[1] : array();
                    if (count($dates) > 0) {
                        $query->andWhere(
                            'task.lkh_start_date <= :date: AND task.lkh_end_date >= :date:', 
                            array(
                                'date' => $dates[0]
                            )
                        );    
                    }
                }
            }
        }
    }

    public static function applySorter($query, $params, $cols) {
        if ( ! isset($params['sort'])) {
            $cols[] = 'MAX(task.lkh_start_date) AS lkh_start_date';
            $query->columns($cols);
            $query->orderBy('lkh_start_date DESC');
        } else {
            $ps = json_decode($params['sort']);

            $sort = array();

            $maps = array(
                'user' => 'user.su_fullname',
                'date' => 'task.lkh_start_date'
            );

            foreach($ps as $e) {
                $dirs = $e->direction;
                $aggr = strtoupper($dirs) == 'ASC' ? 'MIN' : 'MAX';

                if (isset($maps[$e->property])) {
                    $name = $maps[$e->property];
                    $prop = str_replace('.', '_', $name);
                    $sort[] = $prop.' '.$dirs;
                    $cols[] = $aggr.'('.$name.') AS '.$prop;
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