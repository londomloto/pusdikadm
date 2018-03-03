<?php
namespace App\Registration\Controllers;

use App\Registration\Models\Task;
use App\Registration\Models\TaskStatus;
use App\Registration\Models\TaskLabel;
use App\Projects\Models\Project;
use Micro\Helpers\Theme;

class GridController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getQuery();
        $columns = array('task.su_id');
        $query = Task::get()
            ->alias('task')
            ->columns('task.su_id')
            ->join('App\Registration\Models\TaskStatus', 'task.su_id = task_status.tus_su_id', 'task_status', 'left')
            ->join('App\Registration\Models\TaskLabel', 'task.su_id = task_label.tul_su_id', 'task_label', 'left')
            ->join('App\Users\Models\User', 'task.su_created_by = creator.su_id', 'creator', 'left')
            ->groupBy('task.su_id');

        $colors = FALSE;

        if (isset($params['project'])) {
            $query->andWhere('task.su_sp_id = :project:', array('project' => $params['project']));

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

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, $columns);

        $result = $query->paginate()->map(function($row) use ($colors){
            $task = Task::findFirst($row->su_id);
            $data = $task->toArray();

            $data['statuses'] = $task->getCurrentStatuses()->filter(function($e) use ($colors){ 
                $stat = $e->toArray();
                $stat['status_color'] = Theme::val('var(--paper-blue-grey-500)');

                if (isset($colors[$stat['tus_status']])) {
                    $stat['status_color'] = $colors[$stat['tus_status']];
                }
                
                return $stat;
            });

            return $data;
        });

        return $result;
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

            if (isset($json->tus_id)) {
                $query->andWhere('(task_status.tus_id = :tus_id:)', array('tus_id' => $json->tus_id));
            } else {
                if (isset($json->author) && count($json->author) > 0) {
                    $query->inWhere('task.su_created_by', $json->author[1]);
                }
                
                if (isset($json->label) && count($json->label) > 0) {
                    $query->inWhere('task_label.tul_sl_id', $json->label[1]);
                }

                if (isset($json->date) && count($json->date) > 0) {
                    $query->inWhere('task_status.tus_created', $json->date[1]);
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
                'title' => 'su_fullname',
                'due' => 'su_due_date'
            );

            foreach($ps as $e) {
                $dirs = $e->direction;
                $aggr = strtoupper($dirs) == 'ASC' ? 'MIN' : 'MAX';

                if (isset($maps[$e->property])) {
                    $name = $maps[$e->property];
                    $sort[] = $name.' '.$dirs;
                    $cols[] = $aggr.'(task.'.$name.') AS '.$name;
                } else if ($e->property == 'created') {
                    $sort[] = 'su_created_dt '.$dirs;
                    $cols[] = $aggr.'(task.su_created_dt) AS su_created_dt';
                } else if ($e->property == 'creator') {
                    $sort[] = 'su_fullname '.$dirs;
                    $cols[] = $aggr.'(creator.su_fullname) AS su_fullname';
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