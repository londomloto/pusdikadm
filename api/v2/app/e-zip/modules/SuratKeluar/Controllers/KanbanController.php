<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\Task;
use App\SuratKeluar\Models\TaskStatus;
use App\SuratKeluar\Models\TaskLabel;
use App\Projects\Models\Project;
use App\Activities\Models\Activity;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $auth = $this->auth->user();
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;
        
        $columns = array(
            'task_status.tsks_id',
            'task_status.tsks_tsk_id',
            'task_status.tsks_status',
            'task_status.tsks_target',
            'task_status.tsks_worker',
            'task_status.tsks_deleted',
            'task_status.tsks_created'
        );

        $query = TaskStatus::get()
            ->alias('task_status')
            ->columns($columns) 
            ->join('App\SuratKeluar\Models\Task', 'task_status.tsks_tsk_id = task.tsk_id', 'task')
            ->join('App\SuratKeluar\Models\TaskLabel', 'task.tsk_id = task_label.tskl_tsk_id', 'task_label', 'left')
            ->join('App\SuratKeluar\Models\TaskUser', 'task.tsk_id = task_user.tsku_tsk_id', 'task_user', 'left')
            ->join('App\Labels\Models\Label', 'task_label.tskl_sl_id = label.sl_id', 'label', 'left')
            //->join('App\Users\Models\User', 'task.tsk_to = receiver.su_id', 'receiver', 'left')
            ->join('App\Categories\Models\Category', 'task.tsk_category = category.sct_id', 'category', 'left')
            ->groupBy('task_status.tsks_id');

        $query->inWhere('task_user.tsku_su_id', array($auth['su_id']));

        if ($project) {
            $query->andWhere('task.tsk_task_project = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('task_status.tsks_status', $statuses);
        }

        $query->andWhere('task_status.tsks_deleted = 0');

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        //print_r($query->getBuilder()->getQuery()->getSql());

        $result = $query->paginate()
            ->filter(function($stat) {
                
                $task = Task::findFirst($stat->tsks_tsk_id);
                $stat = $stat->toArray();

                $item = array();
                $item['task'] = NULL;
                $item['status'] = $stat;
                $item['labels'] = array();
                $item['users'] = array();
                $item['perms'] = array();
                $item['files'] = array();
                $item['exams'] = array();
                $item['authors'] = array();
                $item['distributions'] = array();
                $item['dispositions'] = array();

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

                $form['task']['tsk_created_by'] = $auth['su_id'];
                $form['task']['tsk_created_dt'] = date('Y-m-d H:i:s');
                $form['task']['tsk_updated_by'] = $form['task']['tsk_created_by'];
                $form['task']['tsk_updated_dt'] = $form['task']['tsk_created_dt'];

                if ($task->save($form['task'])) {

                    if (isset($form['labels'])) {
                        $task->saveLabels($form['labels']);
                    }

                    if (isset($form['users'])) {
                        $task->saveUsers($form['users']);
                    }

                    if (isset($form['files'])) {
                        $task->saveFiles($form['files']);
                    }

                    $affected = array();
                    $init = $worker->start($form['task']);

                    if ($init['data']) {
                        $status = new TaskStatus();

                        $create = array(
                            'tsks_tsk_id' => $task->tsk_id,
                            'tsks_status' => $init['data']['id'],
                            'tsks_target' => $init['data']['target'],
                            'tsks_worker' => $worker->name(),
                            'tsks_deleted' => 0,
                            'tsks_created' => date('Y-m-d H:i:s')
                        );

                        if ($status->save($create)) {
                            $affected[] = $status->tsks_status;
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

            $form['task']['tsk_updated_dt'] = date('Y-m-d H:i:s');
            $form['task']['tsk_updated_by'] = $auth['su_id'];

            if (empty($form['task']['tsk_task_due'])) {
                $form['task']['tsk_task_due'] = NULL;
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

                if (isset($form['files'])) {
                    $task->saveFiles($form['files']);
                }

                $task->resumeLog();

                if ($send) {
                    $move = array();
                    $curr = $task->getCurrentStatuses();

                    $worker = $this->bpmn->worker($post['worker']);
                    $change = array();

                    foreach($curr as $c) {
                        $next = $worker->next($c->tsks_status, $form['task']);
                        
                        $affected[] = $c->tsks_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->andWhere('tsks_tsk_id = :id: AND tsks_deleted = 0', array('id' => $task->tsk_id))
                                ->inWhere('tsks_status', $nextids)
                                ->execute()
                                ->delete();
                            
                            foreach($next['data'] as $n) {

                                $affected[] = $n['id'];

                                $found = TaskStatus::findFirst(array(
                                    'tsks_tsk_id = :id: AND tsks_status = :status: AND tsks_deleted = 0',
                                    'bind' => array(
                                        'id' => $task->tsk_id,
                                        'status' => $n['id']
                                    )
                                ));

                                if ( ! $found) {
                                    $status = new TaskStatus();

                                    $create = array(
                                        'tsks_tsk_id' => $task->tsk_id,
                                        'tsks_status' => $n['id'],
                                        'tsks_target' => $n['target'],
                                        'tsks_worker' => $worker->name(),
                                        'tsks_deleted' => 0,
                                        'tsks_created' => date('Y-m-d H:i:s')
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
                            'ta_task_id' => $task->tsk_id,
                            'ta_sp_id' => $task->tsk_task_project,
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
                            $m->save(array('tsks_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $affected[] = $c->tsks_status;                 
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
                'destination' => 'task.tsk_to',
                'date' => 'task.tsk_date',
                'category' => 'category.sct_name',
                'label' => 'label.sl_label',
                'tsk_agenda' => 'task.tsk_agenda',
                'tsk_no' => 'task.tsk_no',
                'tsk_to' => 'task.tsk_to',
                'tsk_subject' => 'task.tsk_subject'
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
            
            if (isset($json->tsks_id)) {
                $query->andWhere('(task_status.tsks_id = :tsks_id:)', array('tsks_id' => $json->tsks_id));
            } else {
                if (isset($json->user) && count($json->user) > 0) {
                    $query->inWhere('user.su_id', $json->user[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('task_label.tskl_sl_id', $json->label[1]);
                }

                if (isset($json->destination) && count($json->destination) > 0) {
                    $query->inWhere('task.tsk_to', $json->destination[1]);
                }

                if (isset($json->category) && count($json->category) > 0) {
                    $query->inWhere('task.tsk_category', $json->category[1]);
                }

                if (isset($json->date) && count($json->date) > 0) {
                    $query->inWhere('task.tsk_date', $json->date[1]);
                }
            }
        }
    }

    public static function applySorter($query, $params, $cols) {
        if ( ! isset($params['sort'])) {
            $cols[] = 'MAX(task.tsk_date) AS tsk_date';
            $query->columns($cols);
            $query->orderBy('tsk_date DESC');
        } else {
            $ps = json_decode($params['sort']);
            $sort = array();

            $maps = array(
                'tsk_no' => 'task.tsk_no',
                'tsk_date' => 'task.tsk_date',
                'tsk_agenda' => 'task.tsk_agenda',
                'sct_weight' => 'category.sct_weight'
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