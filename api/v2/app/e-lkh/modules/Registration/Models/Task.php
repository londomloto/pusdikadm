<?php
namespace App\Registration\Models;

use App\Activities\Models\Activity;
use Micro\Helpers\Date as DateHelper;
use Phalcon\Mvc\Model\Relation;

class Task extends \App\Users\Models\User implements \App\Tasks\Interfaces\TaskModel {
    
    private $__loggable = TRUE;
    private $__snapshot = NULL;

    public function initialize() {
        parent::initialize();

        $this->hasMany(
            'su_id',
            'App\Registration\Models\TaskStatus',
            'tus_su_id',
            array(
                'alias' => 'Statuses',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'su_id',
            'App\Registration\Models\TaskLabel',
            'tul_su_id',
            array(
                'alias' => 'TaskLabels',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'su_id',
            'App\Registration\Models\TaskLabel',
            'tul_su_id',
            'tul_sl_id',
            'App\Labels\Models\Label',
            'sl_id',
            array(
                'alias' => 'Labels'
            )
        );

        $this->hasOne(
            'su_created_by',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->belongsTo(
            'su_task_project',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Project'
            )
        );

        $this->hasMany(
            'su_id',
            'App\Registration\Models\TaskUser',
            'tru_task',
            array(
                'alias' => 'TaskUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'su_id',
            'App\Registration\Models\TaskUser',
            'tru_task',
            'tru_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Users'
            )
        );
    }

    public function getScope() {
        return 'registration';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            $log = Activity::log('create', array(
                'ta_task_ns' => $this->getScope(),
                'ta_task_id' => $this->su_id,
                'ta_sp_id' => $this->su_task_project
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }
    
    public function beforeDelete() {
        if ($this->__loggable) {
            $log = Activity::log('delete', array(
                'ta_task_ns' => $this->getScope(),
                'ta_task_id' => $this->su_id,
                'ta_sp_id' => $this->su_task_project
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['su_task_due_formatted'] = DateHelper::format($this->su_task_due);
        $data['su_created_dt_relative'] = DateHelper::formatRelative($this->su_created_dt);

        if ($this->creator) {
            $data['creator_su_fullname'] = $this->creator->getName();
            $data['creator_sr_name'] = $this->creator->role ? $this->creator->role->sr_name : '';
            $data['creator_su_avatar_thumb'] = $this->creator->getAvatarThumb();
        }

        $data['su_task_link'] = $this->getLink();

        return $data;
    }

    public function suspendLog() {
        $this->__loggable = FALSE;
    }

    public function resumeLog() {
        $this->__loggable = TRUE;
    }

    public function getTitle() {
        return $this->getName();
    }
    
    public function getLink($absolute = FALSE) {
        $stat = $this->getCurrentStatuses()->getFirst();
        $link = NULL;

        if ($stat) {
            $link = 'worksheet/'.$this->project->sp_name.'/task/update/'.$stat->tus_id;

            if ($absolute) {
                $link = \Micro\App::getDefault()->url->getClientUrl().$link;
            } else {
                $link = '/'.$link;
            }
        }
        
        return $link;
    }

    public function getCurrentStatuses() {
        return $this->getStatuses(array(
            'conditions' => 'tus_deleted = 0',
            'orderBy' => 'tus_created DESC'
        ));
    }

    public function saveLabels($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getLabels() as $label) {
            $current[$label->sl_id] = array(
                'sl_id' => $label->sl_id,
                'sl_color' => $label->sl_color,
                'sl_label' => $label->sl_label
            );
        }

        foreach($post as $e) {
            if (isset($current[$e['sl_id']])) {
                $updated[] = $e;
                unset($current[$e['sl_id']]);
            } else {
                $created[] = $e;
            }
        }

        $removed = array_values(array_keys($current));

        if (count($removed) > 0) {
            TaskLabel::get()
                ->inWhere('tul_sl_id', $removed)
                ->andWhere('tul_su_id = :task:', array('task' => $this->su_id))
                ->execute()
                ->delete();

            $labels = array_values($current);

            $log = Activity::log('remove_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->su_task_project,
                'ta_task_id' => $this->su_id,
                'ta_data' => json_encode($labels)
            ));

            if ($log) {
                $log->subscribe();
            }
        }

        if (count($created) > 0) {
            $labels = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->tul_su_id = $this->su_id;
                $r->tul_sl_id = $e['sl_id'];
                $r->save();

                $labels[] = array(
                    'sl_id' => $e['sl_id'],
                    'sl_color' => $e['sl_color'],
                    'sl_label' => $e['sl_label']
                );
            }

            $log = Activity::log('add_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->su_task_project,
                'ta_task_id' => $this->su_id,
                'ta_data' => json_encode($labels)
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function saveUsers($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getUsers() as $user) {
            $current[$user->su_id] = array(
                'su_id' => $user->su_id,
                'su_fullname' => $user->getName()
            );
        }

        foreach($post as $e) {
            if (isset($current[$e['su_id']])) {
                $updated[] = $e;
                unset($current[$e['su_id']]);
            } else {
                $created[] = $e;
            }
        }

        $removed = array_values(array_keys($current));

        if (count($removed) > 0) {
            TaskUser::get()
                ->inWhere('tru_user', $removed)
                ->andWhere('tru_task = :task:', array('task' => $this->su_id))
                ->execute()
                ->delete();

            $users = array_values($current);

            $log = Activity::log('remove_user', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->su_task_project,
                'ta_task_id' => $this->su_id,
                'ta_data' => json_encode($users)
            ));

            if ($log) {
                $log->subscribe();
            }
        }

        if (count($created) > 0) {
            $users = array();

            foreach($created as $e) {
                $r = new TaskUser();

                $r->tru_task = $this->su_id;
                $r->tru_user = $e['su_id'];
                $r->save();

                $users[] = array(
                    'su_id' => $e['su_id'],
                    'su_fullname' => $e['su_fullname']
                );
            }

            $log = Activity::log('add_user', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->su_task_project,
                'ta_task_id' => $this->su_id,
                'ta_data' => json_encode($users)
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function getAssignee() {
        return $this->getUsers()->filter(function($user){
            $data = array();
            
            $data['su_id'] = $user->su_id;
            $data['su_avatar_thumb'] = $user->getAvatarThumb();
            $data['su_fullname'] = $user->su_fullname;
            $data['su_sg_name'] = $user->getGradeName();
            $data['su_no'] = $user->su_no;
            
            return $data;
        });
    }

    public function forward() {

        $app = \Micro\App::getDefault();

        $payload = $this->toArray();
        $statuses = $this->getCurrentStatuses();
        $worker = NULL;
        $affected = array();
        $removed = array();

        foreach($statuses as $status) {
            if (is_null($worker)) {
                $worker = $app->bpmn->worker($status->tus_worker);
            }
            
            $next = $worker->next($status->tus_status, $payload);
            $affected[] = $status->tus_status;

            if (count($next['data']) > 0) {
                $nextids = array_map(function($n){ return $n['id']; }, $next['data']);

                TaskStatus::get()
                    ->inWhere('tus_status', $nextids)
                    ->andWhere('tus_su_id = :id:', array('id' => $this->su_id))
                    ->execute()
                    ->delete();

                foreach($next['data'] as $n) {
                    $affected[] = $n['id'];

                    $found = TaskStatus::findFirst(array(
                        'tus_su_id = :id: AND tus_status = :status: AND tus_deleted = 0',
                        'bind' => array(
                            'id' => $this->su_id,
                            'status' => $n['id']
                        )
                    ));

                    if ( ! $found) {
                        $item = new TaskStatus();
                        
                        $create = array(
                            'tus_su_id' => $this->su_id,
                            'tus_status' => $n['id'],
                            'tus_target' => $n['target'],
                            'tus_worker' => $worker->name(),
                            'tus_deleted' => 0,
                            'tus_created' => date('Y-m-d H:i:s')
                        );
                        
                        if ($item->save($create)) {
                            $removed[] = $status;
                        }
                    } else {
                        // $removed[] = $status;
                    }
                }
            }
        }

        // nothing changed
        if (count($removed) > 0) {
            foreach($removed as $m) {
                $m->save(array('tus_deleted' => 1));
            }
        }
        
        $affected = array_values(array_unique($affected));
        
        return $affected;
    }
}