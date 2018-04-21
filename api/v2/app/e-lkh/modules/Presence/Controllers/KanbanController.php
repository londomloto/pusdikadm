<?php
namespace App\Presence\Controllers;

use App\Presence\Models\Task;
use App\Presence\Models\TaskStatus;
use App\Presence\Models\TaskLabel;
use App\Projects\Models\Project;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;
        
        $columns = array(
            'task_status.tps_id',
            'task_status.tps_tpr_id',
            'task_status.tps_status',
            'task_status.tps_target',
            'task_status.tps_worker',
            'task_status.tps_deleted',
            'task_status.tps_created'
        );

        $query = TaskStatus::get()
            ->alias('task_status')
            ->columns($columns) 
            ->join('App\Presence\Models\Task', 'task_status.tps_tpr_id = task.tpr_id', 'task')
            ->join('App\Presence\Models\TaskLabel', 'task.tpr_id = task_label.tpl_tpr_id', 'task_label', 'left')
            ->join('App\Labels\Models\Label', 'task_label.tpl_sl_id = label.sl_id', 'label', 'left')
            ->join('App\Users\Models\User', 'task.tpr_su_id = user.su_id', 'user', 'left')
            ->groupBy('task_status.tps_id');

        if ($project) {
            $query->andWhere('task.tpr_task_project = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('task_status.tps_status', $statuses);
        }

        $query->andWhere('task_status.tps_deleted = 0');

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        $result = $query->paginate()
            ->filter(function($stat) {
                
                $task = Task::findFirst($stat->tps_tpr_id);
                $stat = $stat->toArray();

                $item = array();
                $item['task'] = NULL;
                $item['status'] = $stat;
                $item['labels'] = array();
                
                if ($task) {
                    $item['task'] = $task->toArray();
                    $item['labels'] = $task->labels->filter(function($label){ return $label->toArray(); });
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

                if (empty($form['task']['tpr_due_date'])) {
                    $today = new \DateTime();
                    $today->modify('+1 day');
                    $form['task']['tpr_due_date'] = $today->format('Y-m-d');
                }

                $form['task']['tpr_created_by'] = $auth['su_id'];
                $form['task']['tpr_created_dt'] = date('Y-m-d H:i:s');
                $form['task']['tpr_updated_by'] = $form['task']['tpr_created_by'];
                $form['task']['tpr_updated_dt'] = $form['task']['tpr_created_dt'];

                if ($task->save($form['task'])) {

                    if (isset($form['labels'])) {
                        $task->saveLabels($form['labels']);
                    }

                    $affected = array();
                    $init = $worker->start($form['task']);

                    if ($init['data']) {
                        $status = new TaskStatus();

                        $create = array(
                            'tps_tpr_id' => $task->tpr_id,
                            'tps_status' => $init['data']['id'],
                            'tps_target' => $init['data']['target'],
                            'tps_worker' => $worker->name(),
                            'tps_deleted' => 0,
                            'tps_created' => date('Y-m-d H:i:s')
                        );

                        if ($status->save($create)) {
                            $affected[] = $status->tps_status;
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

            $form['task']['tpr_updated_dt'] = date('Y-m-d H:i:s');
            $form['task']['tpr_updated_by'] = $auth['su_id'];

            if (empty($form['task']['tpr_task_due'])) {
                $form['task']['tpr_task_due'] = NULL;
            }

            $affected = array();

            if (FALSE === $logs || $send) {
                $task->suspendLog();
            }

            if ($task->save($form['task'])) {

                if (isset($form['labels'])) {
                    $task->saveLabels($form['labels']);
                }

                $task->resumeLog();

                if ($send) {
                    $move = array();
                    $curr = $task->getCurrentStatuses();

                    $worker = $this->bpmn->worker($post['worker']);

                    foreach($curr as $c) {
                        $next = $worker->next($c->tps_status, $form['task']);
                        
                        $affected[] = $c->tps_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->andWhere('tps_tpr_id = :id: AND tps_deleted = 0', array('id' => $task->tpr_id))
                                ->inWhere('tps_status', $nextids)
                                ->execute()
                                ->delete();
                            
                            foreach($next['data'] as $n) {

                                $affected[] = $n['id'];

                                $found = TaskStatus::findFirst(array(
                                    'tps_tpr_id = :id: AND tps_status = :status: AND tps_deleted = 0',
                                    'bind' => array(
                                        'id' => $task->tpr_id,
                                        'status' => $n['id']
                                    )
                                ));

                                if ( ! $found) {
                                    $status = new TaskStatus();

                                    $create = array(
                                        'tps_tpr_id' => $task->tpr_id,
                                        'tps_status' => $n['id'],
                                        'tps_target' => $n['target'],
                                        'tps_worker' => $worker->name(),
                                        'tps_deleted' => 0,
                                        'tps_created' => date('Y-m-d H:i:s')
                                    );
                                    
                                    if ($status->save($create)) {
                                        $move[] = $c;
                                    }
                                } else {
                                    // $move[] = $c;
                                }
                            }
                        }

                    }

                    // nothing changed
                    if (count($move) > 0) {
                        foreach($move as $m) {
                            $m->save(array('tps_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $affected[] = $c->tps_status;                 
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
                'date' => 'task.tpr_date',
                'label' => 'label.sl_label'
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
            
            if (isset($json->tps_id)) {
                $query->andWhere('(task_status.tps_id = :tps_id:)', array('tps_id' => $json->tps_id));
            } else {
                if (isset($json->user) && count($json->user) > 0) {
                    $query->inWhere('task.tpr_su_id', $json->user[1]);
                }

                if (isset($json->type) && count($json->type) > 0) {
                    $query->inWhere('task.tpr_type', $json->type[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('task_label.tpl_sl_id', $json->label[1]);
                }

                if (isset($json->date) && count($json->date) > 0) {
                    $query->inWhere('task.tpr_date', $json->date[1]);
                }

                if (isset($json->time) && count($json->time) > 0) {
                    $query->inWhere('task.tpr_checkin', $json->time[1]);
                }
            }
        }
    }

    public static function applySorter($query, $params, $cols) {
        if ( ! isset($params['sort'])) {
            $cols[] = 'MAX(task.tpr_created_dt) AS tpr_created_dt';
            $query->columns($cols);
            $query->orderBy('tpr_created_dt DESC');
        } else {
            $ps = json_decode($params['sort']);

            $sort = array();
            $maps = array();

            foreach($ps as $e) {
                $dirs = $e->direction;
                $aggr = strtoupper($dirs) == 'ASC' ? 'MIN' : 'MAX';

                if (isset($maps[$e->property])) {
                    $name = $maps[$e->property];
                    $sort[] = $name.' '.$dirs;
                    $cols[] = $aggr.'(task.'.$name.') AS '.$name;
                } else if ($e->property == 'date') {
                    $sort[] = 'tpr_created_dt '.$dirs;
                    $cols[] = $aggr.'(task.tpr_created_dt) AS tpr_created_dt';
                } else if ($e->property == 'name') {
                    $sort[] = 'su_fullname '.$dirs;
                    $cols[] = $aggr.'(user.su_fullname) AS su_fullname';
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