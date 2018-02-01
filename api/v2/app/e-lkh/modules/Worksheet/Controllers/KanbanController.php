<?php
namespace App\Worksheet\Controllers;

use App\Tasks\Models\Task,
    App\Tasks\Models\TaskStatus,
    App\Tasks\Models\TaskUser,
    App\Tasks\Models\TaskLabel,
    App\Projects\Models\Project;

class KanbanController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getQuery();

        $project = isset($params['project']) ? $params['project'] : FALSE;
        $statuses = isset($params['statuses']) ? json_decode($params['statuses']) : FALSE;
        
        $columns = array(
            'a.tts_id',
            'a.tts_tt_id',
            'a.tts_status',
            'a.tts_target',
            'a.tts_worker',
            'a.tts_data_id',
            'a.tts_query',
            'a.tts_content',
            'a.tts_deleted',
            'a.tts_created'
        );

        $query = TaskStatus::get()
            ->alias('a')
            ->columns($columns) 
            ->join('App\Tasks\Models\Task', 'a.tts_tt_id = b.tt_id', 'b')
            ->join('App\Users\Models\User', 'b.tt_creator_id = c.su_id', 'c', 'left')
            ->join('App\Tasks\Models\TaskLabel', 'b.tt_id = d.ttl_tt_id', 'd', 'left')
            ->groupBy('a.tts_id');

        if ($project) {
            $query->andWhere('b.tt_sp_id = :project:', array('project' => $project));
        }

        if ($statuses && count($statuses) > 0) {
            $query->inWhere('a.tts_status', $statuses);
        }

        $query->andWhere('a.tts_deleted = 0');

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        $result = $query->paginate()
            ->filter(function($stat) {
                
                $task = Task::findFirst($stat->tts_tt_id);
                $stat = $stat->toArray();
                $stat['tts_has_content'] = !empty($stat['tts_content']);

                $item = array();
                $item['task'] = NULL;
                $item['data'] = new \stdClass();
                $item['status'] = $stat;
                $item['labels'] = array();
                $item['users'] = array();
                
                if ($task) {
                    $item['task'] = $task->toArray();
                    $item['labels'] = $task->labels->filter(function($label){ return $label->toArray(); });
                    $item['users'] = $task->users->filter(function($user){ return $user->toArray(); });
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
                $form['task']['tt_updated_dt'] = $form['task']['tt_created_dt'];
                $form['task']['tt_updater_id'] = $form['task']['tt_creator_id'];

                if ($task->save($form['task'])) {

                    if (isset($form['labels'])) {
                        $task->saveLabels($form['labels']);
                    }

                    if (isset($form['users'])) {
                        $task->saveUsers($form['users']);
                    }

                    $affected = array();
                    $init = $worker->start($form['data']);

                    if ($init['data']) {
                        $status = new TaskStatus();

                        if ( ! isset($form['status']['tts_content'])) {
                            $form['status']['tts_content'] = NULL;
                        }

                        if ( ! isset($form['status']['tts_query'])) {
                            $form['status']['tts_query'] = NULL;
                        }

                        if ( ! isset($form['status']['tts_data_id'])) {
                            $form['status']['tts_data_id'] = NULL;
                        }
                        
                        $create = array(
                            'tts_tt_id' => $task->tt_id,
                            'tts_status' => $init['data']['id'],
                            'tts_target' => $init['data']['target'],
                            'tts_worker' => $worker->name(),
                            'tts_deleted' => 0,
                            'tts_created' => date('Y-m-d H:i:s'),
                            'tts_query' => $form['status']['tts_query'],
                            'tts_data_id' => $form['status']['tts_data_id'],
                            'tts_content' => $form['status']['tts_content']
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
                            'task' => $task->toArray(),
                            'data' => $form['data']
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

        if (self::validRequest($post)) {

            $task = Task::findFirst($id);
            $form = $post['record'];

            $auth = $this->auth->user();

            $form['task']['tt_updated_dt'] = date('Y-m-d H:i:s');
            $form['task']['tt_updater_id'] = $auth['su_id'];

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

                if ($send) {
                    $move = array();
                    $curr = $task->getCurrentStatuses();

                    $worker = $this->bpmn->worker($post['worker']);

                    if ( ! isset($form['status']['tts_content'])) {
                        $form['status']['tts_content'] = NULL;
                    }

                    if ( ! isset($form['status']['tts_query'])) {
                        $form['status']['tts_query'] = NULL;
                    }

                    if ( ! isset($form['status']['tts_data_id'])) {
                        $form['status']['tts_data_id'] = NULL;
                    }

                    foreach($curr as $c) {
                        $next = $worker->next($c->tts_status, $form['data']);
                        
                        $affected[] = $c->tts_status;

                        if (count($next['data']) > 0) {

                            $nextids = array_map(function($n){ return $n['id']; }, $next['data']);
                            
                            TaskStatus::get()
                                ->andWhere('tts_tt_id = :id: AND tts_deleted = 0', array('id' => $task->tt_id))
                                ->inWhere('tts_status', $nextids)
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
                                        'tts_created' => date('Y-m-d H:i:s'),
                                        'tts_content' => $form['status']['tts_content'],
                                        'tts_query' => $form['status']['tts_query'],
                                        'tts_data_id' => $form['status']['tts_data_id']
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
                            $m->save(array('tts_deleted' => 1));
                        }
                    }
                } else {
                    $curr = $task->getCurrentStatuses();

                    foreach ($curr as $c) {
                        $c->tts_query = $form['status']['tts_query'];
                        $c->tts_data_id = $form['status']['tts_data_id'];
                        $c->tts_content = $form['status']['tts_content'];

                        $c->save();

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
                    'task' => $task->toArray(),
                    'data' => $form['data']
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

            if ($done) {
                $this->socket->broadcast('notify');
            }
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
            $post['record']['data'],
            $post['record']['status']
        );
    }

    public static function applySearch($query, $params) {
        if (isset($params['query'], $params['fields']) && $params['query'] != '') {
            $search = strtoupper($params['query']);
            $query->andWhere('( a.tts_query LIKE :search: )', array('search' => '%'.$search.'%' ));
        }
    }

    public static function applyFilter($query, $params) {
        if (isset($params['params'])) {
            $json = json_decode($params['params']);

            if (isset($json->tts_id)) {
                $query->andWhere('(a.tts_id = :tts_id:)', array('tts_id' => $json->tts_id));
            } else {
                if (isset($json->author) && count($json->author) > 0) {
                    $query->inWhere('b.tt_creator_id', $json->author[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('d.ttl_sl_id', $json->label[1]);
                }

                if (isset($json->date) && count($json->date) > 0) {
                    $likes = array();

                    foreach($json->date[1] as $d) {
                        $likes[] = "a.tts_query LIKE '%|date=$d|%'";
                    }
                    
                    if (count($likes) > 0) {
                        $query->andWhere('('. implode(' OR ', $likes) .')');
                    }
                }
            }
        }
    }

    public static function applySorter($query, $params, $cols) {
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

}