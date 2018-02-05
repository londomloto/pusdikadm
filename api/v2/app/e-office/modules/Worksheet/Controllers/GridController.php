<?php
namespace App\Worksheet\Controllers;

use App\Tasks\Models\Task,
    App\Tasks\Models\TaskStatus,
    App\Tasks\Models\TaskUser,
    App\Tasks\Models\TaskLabel,
    App\Projects\Models\Project,
    Micro\Helpers\Theme;

class GridController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getQuery();
        $query = Task::get()
            ->alias('b')
            ->columns('b.tt_id')
            ->join('App\Tasks\Models\TaskStatus', 'b.tt_id = a.tts_tt_id', 'a', 'left')
            ->join('App\Users\Models\User', 'b.tt_creator_id = c.su_id', 'c', 'left')
            ->join('App\Tasks\Models\TaskLabel', 'b.tt_id = d.ttl_tt_id', 'd', 'left')
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

        self::applySearch($query, $params);
        self::applyFilter($query, $params);
        self::applySorter($query, $params, array('b.tt_id'));

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