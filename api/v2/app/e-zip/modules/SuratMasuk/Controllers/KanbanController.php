<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\Task;
use App\SuratMasuk\Models\TaskStatus;
use App\SuratMasuk\Models\TaskLabel;
use App\Projects\Models\Project;
use App\Activities\Models\Activity;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $auth = $this->auth->user();
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;
        
        $columns = array(
            'task_status.tsms_id',
            'task_status.tsms_tsm_id',
            'task_status.tsms_status',
            'task_status.tsms_target',
            'task_status.tsms_worker',
            'task_status.tsms_deleted',
            'task_status.tsms_created'
        );

        $query = TaskStatus::get()
            ->alias('task_status')
            ->columns($columns) 
            ->join('App\SuratMasuk\Models\Task', 'task_status.tsms_tsm_id = task.tsm_id', 'task')
            ->join('App\SuratMasuk\Models\TaskLabel', 'task.tsm_id = task_label.tsml_tsm_id', 'task_label', 'left')
            ->join('App\SuratMasuk\Models\TaskUser', 'task.tsm_id = task_user.tsmu_tsm_id', 'task_user', 'left')
            ->join('App\Labels\Models\Label', 'task_label.tsml_sl_id = label.sl_id', 'label', 'left')
            //->join('App\Users\Models\User', 'task.tsm_to = receiver.su_id', 'receiver', 'left')
            ->join('App\Categories\Models\Category', 'task.tsm_category = category.sct_id', 'category', 'left')
            ->groupBy('task_status.tsms_id');

        $query->inWhere('task_user.tsmu_su_id', array($auth['su_id']));

        if ($project) {
            $query->andWhere('task.tsm_task_project = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('task_status.tsms_status', $statuses);
        }

        $query->andWhere('task_status.tsms_deleted = 0');

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        //print_r($query->getBuilder()->getQuery()->getSql());

        $result = $query->paginate()
            ->filter(function($stat) {
                
                $task = Task::findFirst($stat->tsms_tsm_id);
                $stat = $stat->toArray();

                $item = array();
                $item['task'] = NULL;
                $item['status'] = $stat;
                $item['labels'] = array();
                $item['users'] = array();
                $item['perms'] = array();
                $item['files'] = array();
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

                $form['task']['tsm_created_by'] = $auth['su_id'];
                $form['task']['tsm_created_dt'] = date('Y-m-d H:i:s');
                $form['task']['tsm_updated_by'] = $form['task']['tsm_created_by'];
                $form['task']['tsm_updated_dt'] = $form['task']['tsm_created_dt'];

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
                            'tsms_tsm_id' => $task->tsm_id,
                            'tsms_status' => $init['data']['id'],
                            'tsms_target' => $init['data']['target'],
                            'tsms_worker' => $worker->name(),
                            'tsms_deleted' => 0,
                            'tsms_created' => date('Y-m-d H:i:s')
                        );

                        if ($status->save($create)) {
                            $affected[] = $status->tsms_status;
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

            $form['task']['tsm_updated_dt'] = date('Y-m-d H:i:s');
            $form['task']['tsm_updated_by'] = $auth['su_id'];

            if (empty($form['task']['tsm_task_due'])) {
                $form['task']['tsm_task_due'] = NULL;
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
                        $next = $worker->next($c->tsms_status, $form['task']);
                        
                        $affected[] = $c->tsms_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->andWhere('tsms_tsm_id = :id: AND tsms_deleted = 0', array('id' => $task->tsm_id))
                                ->inWhere('tsms_status', $nextids)
                                ->execute()
                                ->delete();
                            
                            foreach($next['data'] as $n) {

                                $affected[] = $n['id'];

                                $found = TaskStatus::findFirst(array(
                                    'tsms_tsm_id = :id: AND tsms_status = :status: AND tsms_deleted = 0',
                                    'bind' => array(
                                        'id' => $task->tsm_id,
                                        'status' => $n['id']
                                    )
                                ));

                                if ( ! $found) {
                                    $status = new TaskStatus();

                                    $create = array(
                                        'tsms_tsm_id' => $task->tsm_id,
                                        'tsms_status' => $n['id'],
                                        'tsms_target' => $n['target'],
                                        'tsms_worker' => $worker->name(),
                                        'tsms_deleted' => 0,
                                        'tsms_created' => date('Y-m-d H:i:s')
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
                            'ta_task_id' => $task->tsm_id,
                            'ta_sp_id' => $task->tsm_task_project,
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
                            $m->save(array('tsms_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $affected[] = $c->tsms_status;                 
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
                'origin' => 'task.tsm_from',
                'date' => 'task.tsm_date',
                'category' => 'category.sct_name',
                'label' => 'label.sl_label',
                'tsm_agenda' => 'task.tsm_agenda',
                'tsm_no' => 'task.tsm_no',
                'tsm_from' => 'task.tsm_from',
                'tsm_subject' => 'task.tsm_subject'
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
            
            if (isset($json->tsms_id)) {
                $query->andWhere('(task_status.tsms_id = :tsms_id:)', array('tsms_id' => $json->tsms_id));
            } else {
                if (isset($json->user) && count($json->user) > 0) {
                    $query->inWhere('user.su_id', $json->user[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('task_label.tsml_sl_id', $json->label[1]);
                }

                if (isset($json->origin) && count($json->origin) > 0) {
                    $query->inWhere('task.tsm_from', $json->origin[1]);
                }

                if (isset($json->category) && count($json->category) > 0) {
                    $query->inWhere('task.tsm_category', $json->category[1]);
                }

                if (isset($json->date) && count($json->date) > 0) {
                    $query->inWhere('task.tsm_date', $json->date[1]);
                }
            }
        }
    }

    public static function applySorter($query, $params, $cols) {
        if ( ! isset($params['sort'])) {
            $cols[] = 'MAX(task.tsm_date) AS tsm_date';
            $query->columns($cols);
            $query->orderBy('tsm_date DESC');
        } else {
            $ps = json_decode($params['sort']);

            $sort = array();

            $maps = array(
                'tsm_no' => 'task.tsm_no',
                'tsm_date' => 'task.tsm_date',
                'tsm_agenda' => 'task.tsm_agenda',
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