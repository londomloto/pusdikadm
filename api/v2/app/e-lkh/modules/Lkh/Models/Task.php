<?php
namespace App\Lkh\Models;

use App\Activities\Models\Activity;
use Micro\Helpers\Date as DateHelper;
use Phalcon\Mvc\Model\Relation;

class Task extends Lkh implements \App\Tasks\Interfaces\TaskModel {
    
    private $__loggable = TRUE;
    private $__snapshot = NULL;
    
    public function initialize() {
        
        parent::initialize();

        $this->hasMany(
            'lkh_id',
            'App\Lkh\Models\TaskStatus',
            'lks_lkh_id',
            array(
                'alias' => 'Statuses',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'lkh_id',
            'App\Lkh\Models\TaskUser',
            'lku_lkh_id',
            array(
                'alias' => 'TaskUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'lkh_id',
            'App\Lkh\Models\TaskUser',
            'lku_lkh_id',
            'lku_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Users'
            )
        );

        $this->hasMany(
            'lkh_id',
            'App\Lkh\Models\TaskLabel',
            'lkl_lkh_id',
            array(
                'alias' => 'TaskLabels',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'lkh_id',
            'App\Lkh\Models\TaskLabel',
            'lkl_lkh_id',
            'lkl_sl_id',
            'App\Labels\Models\Label',
            'sl_id',
            array(
                'alias' => 'Labels'
            )
        );

        $this->hasOne(
            'lkh_created_by',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->belongsTo(
            'lkh_task_project',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Project'
            )
        );
    }

    public function getSource() {
        return 'trx_lkh';
    }

    public function getScope() {
        return 'lkh';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            $log = Activity::log('create', array(
                'ta_task_ns' => $this->getScope(),
                'ta_task_id' => $this->lkh_id,
                'ta_sp_id' => $this->lkh_task_project
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
                'ta_task_id' => $this->lkh_id,
                'ta_sp_id' => $this->lkh_task_project
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['lkh_task_due_formatted'] = DateHelper::format($this->lkh_task_due);
        $data['lkh_created_dt_relative'] = DateHelper::formatRelative($this->lkh_created_dt);

        if (($creator = $this->creator)) {
            
            $data['creator_su_fullname'] = $creator->getName();
            $data['creator_su_no'] = $creator->su_no;
            $data['creator_su_sg_name'] = $creator->getGradeName();
            $data['creator_su_avatar_thumb'] = $creator->getAvatarThumb();
        }

        return $data;
    }

    public function suspendLog() {
        $this->__loggable = FALSE;
    }

    public function resumeLog() {
        $this->__loggable = TRUE;
    }

    public function getLink($absolute = FALSE) {
        $stat = $this->getCurrentStatuses()->getFirst();
        $link = NULL;

        if ($stat) {
            $link = 'worksheet/'.$this->project->sp_name.'/task/update/'.$stat->lks_id;

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
            'conditions' => 'lks_deleted = 0',
            'orderBy' => 'lks_created DESC'
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
                ->inWhere('lkl_sl_id', $removed)
                ->andWhere('lkl_lkh_id = :task:', array('task' => $this->lkh_id))
                ->execute()
                ->delete();

            $labels = array_values($current);

            $log = Activity::log('remove_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->lkh_task_project,
                'ta_task_id' => $this->lkh_id,
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
                $r->lkl_lkh_id = $this->lkh_id;
                $r->lkl_sl_id = $e['sl_id'];
                $r->save();

                $labels[] = array(
                    'sl_id' => $e['sl_id'],
                    'sl_color' => $e['sl_color'],
                    'sl_label' => $e['sl_label']
                );
            }

            $log = Activity::log('add_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->lkh_task_project,
                'ta_task_id' => $this->lkh_id,
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
                ->inWhere('lku_su_id', $removed)
                ->andWhere('lku_lkh_id = :task:', array('task' => $this->lkh_id))
                ->execute()
                ->delete();

            $users = array_values($current);

            $log = Activity::log('remove_user', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->lkh_task_project,
                'ta_task_id' => $this->lkh_id,
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

                $r->lku_lkh_id = $this->lkh_id;
                $r->lku_su_id = $e['su_id'];
                $r->save();

                $users[] = array(
                    'su_id' => $e['su_id'],
                    'su_fullname' => $e['su_fullname']
                );
            }

            $log = Activity::log('add_user', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->lkh_task_project,
                'ta_task_id' => $this->lkh_id,
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

    }
}