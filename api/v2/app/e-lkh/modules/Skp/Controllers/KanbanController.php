<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Task;
use App\Skp\Models\TaskStatus;
use App\Skp\Models\TaskLabel;
use App\Projects\Models\Project;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $auth = $this->auth->user();
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;
        
        $columns = array(
            'task_status.sks_id',
            'task_status.sks_skp_id',
            'task_status.sks_status',
            'task_status.sks_target',
            'task_status.sks_worker',
            'task_status.sks_deleted',
            'task_status.sks_created'
        );

        $query = TaskStatus::get()
            ->alias('task_status')
            ->columns($columns) 
            ->join('App\Skp\Models\Task', 'task_status.sks_skp_id = task.skp_id', 'task')
            ->join('App\Skp\Models\TaskLabel', 'task.skp_id = task_label.skl_skp_id', 'task_label', 'left')
            ->join('App\Skp\Models\TaskUser', 'task.skp_id = task_user.sku_skp_id', 'task_user', 'left')
            ->join('App\Labels\Models\Label', 'task_label.skl_sl_id = label.sl_id', 'label', 'left')
            ->join('App\Users\Models\User', 'task.skp_su_id = user.su_id', 'user', 'left')
            ->groupBy('task_status.sks_id');

        $query->inWhere('task_user.sku_su_id', array($auth['su_id']));

        if ($project) {
            $query->andWhere('task.skp_task_project = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('task_status.sks_status', $statuses);
        }

        $query->andWhere('task_status.sks_deleted = 0');

        //self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        $result = $query->paginate()
            ->filter(function($stat) {
                
                $task = Task::findFirst($stat->sks_skp_id);
                $stat = $stat->toArray();

                $item = array();
                $item['task'] = NULL;
                $item['status'] = $stat;
                $item['labels'] = array();
                $item['items'] = array();
                $item['extra'] = array();
                $item['users'] = array();

                if ($task) {
                    $item['task'] = $task->toArray();
                    $item['labels'] = $task->labels->filter(function($label){ return $label->toArray(); });
                    // $item['items'] = $task->getSortedItems();
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

                $form['task']['skp_created_by'] = $auth['su_id'];
                $form['task']['skp_created_dt'] = date('Y-m-d H:i:s');
                $form['task']['skp_updated_by'] = $form['task']['skp_created_by'];
                $form['task']['skp_updated_dt'] = $form['task']['skp_created_dt'];

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
                            'sks_skp_id' => $task->skp_id,
                            'sks_status' => $init['data']['id'],
                            'sks_target' => $init['data']['target'],
                            'sks_worker' => $worker->name(),
                            'sks_deleted' => 0,
                            'sks_created' => date('Y-m-d H:i:s')
                        );

                        if ($status->save($create)) {
                            $affected[] = $status->sks_status;
                        }
                        
                    }

                    $affected = array_values(array_unique($affected));

                    return array(
                        'success' => TRUE,
                        'data' => array(
                            'affected' => $affected,
                            'task' => $task->toArray(),
                            //'items' => $task->getSortedItems()
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

            $form['task']['skp_updated_dt'] = date('Y-m-d H:i:s');
            $form['task']['skp_updated_by'] = $auth['su_id'];

            if (empty($form['task']['skp_task_due'])) {
                $form['task']['skp_task_due'] = NULL;
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

                    foreach($curr as $c) {
                        $next = $worker->next($c->sks_status, $form['task']);
                        
                        $affected[] = $c->sks_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->andWhere('sks_skp_id = :id: AND sks_deleted = 0', array('id' => $task->skp_id))
                                ->inWhere('sks_status', $nextids)
                                ->execute()
                                ->delete();
                            
                            foreach($next['data'] as $n) {

                                $affected[] = $n['id'];

                                $found = TaskStatus::findFirst(array(
                                    'sks_skp_id = :id: AND sks_status = :status: AND sks_deleted = 0',
                                    'bind' => array(
                                        'id' => $task->skp_id,
                                        'status' => $n['id']
                                    )
                                ));

                                if ( ! $found) {
                                    $status = new TaskStatus();

                                    $create = array(
                                        'sks_skp_id' => $task->skp_id,
                                        'sks_status' => $n['id'],
                                        'sks_target' => $n['target'],
                                        'sks_worker' => $worker->name(),
                                        'sks_deleted' => 0,
                                        'sks_created' => date('Y-m-d H:i:s')
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
                            $m->save(array('sks_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $affected[] = $c->sks_status;                 
                    }
                }
            }

            $affected = array_values(array_unique($affected));

            return array(
                'success' => TRUE,
                'data' => array(
                    'affected' => $affected,
                    'task' => $task->toArray(),
                    //'items' => $task->getSortedItems()
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
                'date' => 'task.su_created_dt',
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
            
            if (isset($json->sks_id)) {
                $query->andWhere('(task_status.sks_id = :sks_id:)', array('sks_id' => $json->sks_id));
            } else {
                if (isset($json->user) && count($json->user) > 0) {
                    $query->inWhere('user.su_id', $json->user[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('task_label.skl_sl_id', $json->label[1]);
                }

                if (isset($json->date) && count($json->date) > 0) {
                    $query->inWhere('task.skp_created_dt', $json->date[1]);
                }
            }
        }
    }

    public static function applySorter($query, $params, $cols) {
        if ( ! isset($params['sort'])) {
            $cols[] = 'MAX(task.skp_created_dt) AS skp_created_dt';
            $query->columns($cols);
            $query->orderBy('skp_created_dt DESC');
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
                    $sort[] = 'skp_created_dt '.$dirs;
                    $cols[] = $aggr.'(task.skp_created_dt) AS skp_created_dt';
                } else if ($e->property == 'user') {
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