<?php
namespace App\Kanban\Controllers;

use App\Tasks\Models\Task,
    App\Tasks\Models\TaskStatus,
    App\Tasks\Models\TaskUser,
    App\Tasks\Models\TaskLabel,
    App\Tasks\Models\TaskComment,
    App\Projects\Models\Project,
    App\System\Models\Autonumber,
    Micro\Helpers\Theme;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;

        $query = TaskStatus::get()
            ->alias('a')
            ->columns('a.tts_id') 
            ->join('App\Tasks\Models\Task', 'a.tts_tt_id = b.tt_id', 'b')
            ->join('App\Users\Models\User', 'b.tt_creator_id = c.su_id', 'c', 'left')
            ->join('App\Tasks\Models\TaskLabel', 'b.tt_id = d.ttl_tt_id', 'd', 'left')
            ->join('App\Labels\Models\Label', 'd.ttl_sl_id = e.sl_id', 'e', 'left')
            ->join('App\Tasks\Models\TaskUser', 'b.tt_id = f.ttu_tt_id', 'f', 'left')
            ->join('App\Users\Models\User', 'f.ttu_su_id = g.su_id', 'g', 'left')
            ->filterable()
            ->groupBy('a.tts_id');

        if ($project) {
            $query->andWhere('b.tt_sp_id = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('a.tts_status', $statuses);
        }

        $query->andWhere('a.tts_deleted = 0');

        $this->applySearch($query, $params);
        $this->applyFilter($query, $params);
        $this->applySorter($query, $params, array('a.tts_id'));

        $bpmn = $this->bpmn;
        $workers = array();

        $key = FALSE;

        if (isset($params['params'])) {
            $json = json_decode($params['params']);
            $key = isset($json->tts_id) ? $json->tts_id : FALSE;
        }

        $data = $query->execute()
            ->filter(function($row) use ($bpmn, &$workers, $key) {
                
                $stat = TaskStatus::findFirst($row->tts_id);
                $task = $stat->task;

                $item = array();
                $item['task'] = NULL;
                $item['data'] = new \stdClass();
                $item['status'] = $stat->toArray();
                $item['labels'] = array();
                $item['users'] = array();
                
                if ($task) {
                    $item['task'] = $task->toArray();
                    $item['labels'] = $task->getLabels()->filter(function($label){ return $label->toArray(); });
                    $item['users'] = $task->getUsers()->filter(function($user){ return $user->toArray(); });

                    if ($key) {

                        if ( ! isset($workers[$stat->tts_worker])) {
                            $workers[$stat->tts_worker] = $bpmn->worker($stat->tts_worker);
                        }

                        $worker = $workers[$stat->tts_worker];
                        $data = $worker->model()->data($task->tt_data_id);

                        if ($data) {
                            $item['data'] = $data->toArray();
                        }    
                    }

                }

                return $item;
                
            });

        return array(
            'success' => TRUE,
            'data' => $data
        );
        
    }

    public function applySearch($query, $params) {
        if (isset($params['query'], $params['fields']) && $params['query'] != '') {
            $pf = array_flip(json_decode($params['fields']));
            $pq = strtoupper($params['query']);
            
            $where = array();
            $bind = array();

            if (isset($pf['author'])) {
                unset($pf['author']);
                $where[] = 'UPPER(c.su_fullname) LIKE :author:';
                $bind['author'] = '%'.$pq.'%';
            }

            if (isset($pf['label'])) {
                unset($pf['label']);
                $where[] = 'UPPER(e.sl_label) LIKE :label:';
                $bind['label'] = '%'.$pq.'%';
            }

            if (isset($pf['assignee'])) {
                unset($pf['assignee']);
                $where[] = 'UPPER(g.su_fullname) LIKE :assignee:';
                $bind['assignee'] = '%'.$pq.'%';
            }

            // extra ?
            if (count($pf) > 0)  {
                $fields = $query->getFields();
                $driver = $this->db->getType();
                $valid  = FALSE;

                if ($driver == 'pgsql') {
                    foreach($pf as $k => $v) {
                        $attr = isset($fields->{$k}) ? $fields->{$k} : FALSE;
                        if ($attr) {
                            $where[] = 'UPPER(CAST('.$attr['field'].' AS VARCHAR)) LIKE :q:';
                            $valid = TRUE;
                        }
                    }
                } else {
                    foreach($pf as $k => $i) {
                        $attr = isset($fields->{$k}) ? $fields->{$k} : FALSE;
                        if ($attr) {
                            $where[] = 'UPPER('.$attr['field'].') LIKE :q:';
                            $valid = TRUE;
                        }
                    }
                }

                if ($valid) {
                    $bind['q'] = '%'.$pq.'%';
                }
            }

            if (count($where) > 0) {
                $where = '('.implode(' OR ', $where).')';
                $query->andWhere($where, $bind);
            }
        }
    }

    public function applyFilter($query, $params) {
        if (isset($params['params'])) {
            $pp = json_decode($params['params']);
            if (isset($pp->assignee) && count($pp->assignee[1]) > 0) {
                $query->inWhere('f.ttu_su_id', $pp->assignee[1]);
            }
            if (isset($pp->label) && count($pp->label) > 0) {
                $query->inWhere('d.ttl_sl_id', $pp->label[1]);
            }
            if (isset($pp->author) && count($pp->author) > 0) {
                $query->inWhere('b.tt_creator_id', $pp->author[1]);
            }
        }
    }

    public function applySorter($query, $params, $cols) {
        if ( ! isset($params['sort'])) {
            $cols[] = 'MAX(b.tt_created_dt) AS tt_created_dt';
            $query->columns($cols);
            $query->orderBy('tt_created_dt DESC');
        } else {
            $ps = json_decode($params['sort']);

            $sort = array();
            $maps = array(
                'title' => 'tt_title',
                'due' => 'tt_due_date'
            );

            foreach($ps as $e) {
                $dirs = $e->direction;
                $aggr = strtoupper($dirs) == 'ASC' ? 'MIN' : 'MAX';

                if (isset($maps[$e->property])) {
                    $name = $maps[$e->property];
                    $sort[] = $name.' '.$dirs;
                    $cols[] = $aggr.'(b.'.$name.') AS '.$name;
                } else if ($e->property == 'created') {
                    $sort[] = 'tt_created_dt '.$dirs;
                    $cols[] = $aggr.'(b.tt_created_dt) AS tt_created_dt';
                } else if ($e->property == 'creator') {
                    $sort[] = 'su_fullname '.$dirs;
                    $cols[] = $aggr.'(c.su_fullname) AS su_fullname';
                }
            }

            if (count($sort) > 0) {
                $sort = implode(', ', $sort);

                $query->columns($cols);
                $query->orderBy($sort);
            }
        }
    }

    public function findGridAction() {
        $params = $this->request->getQuery();
        $query = Task::get()
            ->alias('b')
            ->columns('b.tt_id')
            ->join('App\Users\Models\User', 'b.tt_creator_id = c.su_id', 'c', 'left')
            ->join('App\Tasks\Models\TaskLabel', 'b.tt_id = d.ttl_tt_id', 'd', 'left')
            ->join('App\Labels\Models\Label', 'd.ttl_sl_id = e.sl_id', 'e', 'left')
            ->join('App\Tasks\Models\TaskUser', 'b.tt_id = f.ttu_tt_id', 'f', 'left')
            ->join('App\Users\Models\User', 'f.ttu_su_id = g.su_id', 'g', 'left')
            ->groupBy('b.tt_id');

        $colors = FALSE;

        if (isset($params['project'])) {
            $query->andWhere('b.tt_sp_id = :project:', array('project' => $params['project']));

            $project = Project::findFirst($params['project']);

            if ($project) {
                $worksheet = \App\Kanban\Models\KanbanSetting::findFirst($project->sp_worksheet_id);
                if ($worksheet) {
                    $ws = $worksheet->getWorkspaces();
                    $wp = count($ws) > 0 ? $ws[0] : FALSE;

                    if ($wp) {
                        foreach($wp['deploy'] as $stat => $keys) {
                            if (count($keys) > 0) {
                                $panel = \App\Kanban\Models\KanbanPanel::findFirst($keys[0]);
                                if ($panel) {
                                    $colors[$stat] = $panel->kp_accent;
                                }
                            }
                        }
                    }
                }
            }
        }

        $this->applySearch($query, $params);
        $this->applyFilter($query, $params);
        $this->applySorter($query, $params, array('b.tt_id'));

        $result = $query->paginate()->map(function($row) use ($colors){
            $task = Task::findFirst($row->tt_id);
            $data = $task->toArray();

            $data['statuses'] = $task->getCurrentStatuses()->filter(function($e) use ($colors){ 
                $stat = $e->toArray();
                $stat['status_color'] = Theme::val('var(--paper-blue-grey-500)');

                if (isset($colors[$stat['tts_status']])) {
                    $stat['status_color'] = $colors[$stat['tts_status']];
                }
                
                return $stat;
            });

            return $data;
        });

        return $result;
    }

    public function createAction() {
        $post = $this->request->getJson();
        $auth = $this->auth->user();
        
        if (isset($post['worker'], $post['record'], $post['record']['data'], $post['record']['task'])) {
            $worker = $this->bpmn->worker($post['worker']);

            if ($worker) {
                $task = new Task();
                $form = $post['record'];

                if (empty($form['task']['tt_flag'])) {
                    $stat = $worker->statuses();
                    if (isset($stat['data']) && count($stat['data']) > 0) {
                        $init = $stat['data'][0];
                        $form['task']['tt_flag'] = $init['text'];
                    }
                }   

                if (empty($form['task']['tt_due_date'])) {
                    $today = new \DateTime();
                    $today->modify('+1 day');
                    $form['task']['tt_due_date'] = $today->format('Y-m-d');
                }

                $form['task']['tt_creator_id'] = $auth['su_id'];
                $form['task']['tt_created_dt'] = date('Y-m-d H:i:s');

                if ($task->save($form['task'])) {

                    if (isset($form['labels'])) {
                        $task->saveLabels($form['labels']);
                    }

                    if (isset($form['users'])) {
                        $task->saveUsers($form['users']);
                    }

                    // save data
                    $create = $worker->model()->save($form['data']);
                    $message = '';

                    if ($create->success) {
                        $task->tt_data_id = $worker->model()->id($create->data);
                        $task->save();

                        $arrayTask = $task->toArray();
                        $arrayData = $create->data->toArray();
                        $payload = $arrayData;

                        
                    } else {
                        $arrayTask = $task->toArray();
                        $arrayData = array();
                        $payload = $arrayTask;
                        $message = isset($create->message) ? $create->message : '';
                    }
                    
                    $init = $worker->start($payload);
                    $affected = array();

                    if ($init['data']) {
                        $status = new TaskStatus();

                        $create = array(
                            'tts_tt_id' => $task->tt_id,
                            'tts_status' => $init['data']['id'],
                            'tts_target' => $init['data']['target'],
                            'tts_worker' => $worker->name(),
                            'tts_deleted' => 0,
                            'tts_created' => date('Y-m-d H:i:s')
                        );

                        if ($status->save($create)) {
                            $affected[] = $status->tts_status;
                        }
                        
                    }

                    $affected = array_values(array_unique($affected));

                    $this->socket->broadcast('notify');

                    return array(
                        'success' => TRUE,
                        'data' => array(
                            'affected' => $affected,
                            'task' => $arrayTask,
                            'data' => $arrayData
                        ),
                        'message' => $message
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

        if (isset($post['worker'], $post['record'], $post['record']['data'], $post['record']['task'])) {
            $task = Task::findFirst($id);
            $form = $post['record'];

            if (empty($form['task']['tt_due_date'])) {
                $form['task']['tt_due_date'] = NULL;
            }

            $affected = array();

            if ($task->save($form['task'])) {

                if (isset($form['labels'])) {
                    $task->saveLabels($form['labels']);
                }

                if (isset($form['users'])) {
                    $task->saveUsers($form['users']);
                }

                // update data too...
                $worker = $this->bpmn->worker($post['worker']);
                $update = $worker->model()->save($form['data']);
                $message = '';

                if ($update->success) {
                    $arrayTask = $task->toArray();
                    $arrayData = array_merge($form['data'], $update->data->toArray());
                    $payload = $arrayData;
                } else {
                    $arrayTask = $task->toArray();
                    $arrayData = array();
                    $message = isset($update->message) ? $update->message : '';
                    $payload = array_merge($form['task'], $task->toArray());
                }

                if ($send) {
                    $move = array();
                    $curr = $task->getCurrentStatuses();

                    foreach($curr as $c) {
                        $next = $worker->next($c->tts_status, $payload);
                        
                        $affected[] = $c->tts_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->inWhere('tts_status', $nextids)
                                ->andWhere('tts_id = :id:', array('id' => $task->tt_id))
                                ->execute()
                                ->delete();

                            foreach($next['data'] as $n) {

                                $affected[] = $n['id'];

                                $found = TaskStatus::findFirst(array(
                                    'tts_tt_id = :id: AND tts_status = :status: AND tts_deleted = 0',
                                    'bind' => array(
                                        'id' => $task->tt_id,
                                        'status' => $n['id']
                                    )
                                ));

                                if ( ! $found) {
                                    $status = new TaskStatus();
                                    $create = array(
                                        'tts_tt_id' => $task->tt_id,
                                        'tts_status' => $n['id'],
                                        'tts_target' => $n['target'],
                                        'tts_worker' => $worker->name(),
                                        'tts_deleted' => 0,
                                        'tts_created' => date('Y-m-d H:i:s')
                                    );
                                    
                                    if ($status->save($create)) {
                                        $move[] = $c;
                                    }
                                } else {
                                    $move[] = $c;
                                }
                            }
                        }

                    }

                    // nothing changed
                    if (count($move) > 0) {
                        foreach($move as $m) {
                            $m->save(array('tts_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $affected[] = $c->tts_status;                 
                    }
                }
            }

            $affected = array_values(array_unique($affected));
            
            $this->socket->broadcast('notify');

            return array(
                'success' => TRUE,
                'data' => array(
                    'affected' => $affected,
                    'task' => $arrayTask,
                    'data' => $arrayData
                ),
                'message' => $message
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

            if ($done) {
                $this->socket->broadcast('notify');
            }
        }

        return array(
            'success' => $done
        );
    }

}