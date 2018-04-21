<?php
namespace App\Skp\Models;

use App\Activities\Models\Activity;
use Micro\Helpers\Date as DateHelper;
use Phalcon\Mvc\Model\Relation;

class Task extends Skp implements \App\Tasks\Interfaces\TaskModel {
    
    private $__loggable = TRUE;
    private $__snapshot = NULL;
    
    public function initialize() {
        
        parent::initialize();


        $this->hasMany(
            'skp_id',
            'App\Skp\Models\TaskStatus',
            'sks_skp_id',
            array(
                'alias' => 'Statuses',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'skp_id',
            'App\Skp\Models\TaskUser',
            'sku_skp_id',
            array(
                'alias' => 'TaskUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'skp_id',
            'App\Skp\Models\TaskUser',
            'sku_skp_id',
            'sku_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Users'
            )
        );

        $this->hasMany(
            'skp_id',
            'App\Skp\Models\TaskLabel',
            'skl_skp_id',
            array(
                'alias' => 'TaskLabels',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'skp_id',
            'App\Skp\Models\TaskLabel',
            'skl_skp_id',
            'skl_sl_id',
            'App\Labels\Models\Label',
            'sl_id',
            array(
                'alias' => 'Labels'
            )
        );

        $this->hasOne(
            'skp_created_by',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->belongsTo(
            'skp_task_project',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Project'
            )
        );
    }

    public function getSource() {
        return 'trx_skp';
    }

    public function getScope() {
        return 'skp';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            $log = Activity::log('create', array(
                'ta_task_ns' => $this->getScope(),
                'ta_task_id' => $this->skp_id,
                'ta_sp_id' => $this->skp_task_project
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['skp_task_due_formatted'] = DateHelper::format($this->skp_task_due);
        $data['skp_created_dt_relative'] = DateHelper::formatRelative($this->skp_created_dt);

        if (($creator = $this->creator)) {
            
            $data['creator_su_fullname'] = $creator->getName();
            $data['creator_sr_name'] = $creator->role ? $creator->role->sr_name : '';
            $data['creator_su_avatar_thumb'] = $creator->getAvatarThumb();
            $data['creator_su_sj_name'] = $creator->job ? $creator->job->sj_name : '';
        }

        return $data;
    }

    public function suspendLog() {
        $this->__loggable = FALSE;
    }

    public function resumeLog() {
        $this->__loggable = TRUE;
    }

    public function getLink() {
        $stat = $this->getCurrentStatuses()->getFirst();

        if ($stat) {
            return '/worksheet/'.$this->project->sp_name.'/task/update/'.$stat->sks_id;
        } else {
            return NULL;
        }
    }

    public function getCurrentStatuses() {
        return $this->getStatuses(array(
            'conditions' => 'sks_deleted = 0',
            'orderBy' => 'sks_created DESC'
        ));
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
                ->inWhere('sku_su_id', $removed)
                ->andWhere('sku_skp_id = :task:', array('task' => $this->skp_id))
                ->execute()
                ->delete();

            $users = array_values($current);

            $log = Activity::log('remove_user', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->skp_task_project,
                'ta_task_id' => $this->skp_id,
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

                $r->sku_skp_id = $this->skp_id;
                $r->skp_su_id = $e['su_id'];
                $r->save();

                $users[] = array(
                    'su_id' => $e['su_id'],
                    'su_fullname' => $e['su_fullname']
                );
            }

            $log = Activity::log('add_user', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->skp_task_project,
                'ta_task_id' => $this->skp_id,
                'ta_data' => json_encode($users)
            ));

            if ($log) {
                $log->subscribe();
            }
        }
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
                ->inWhere('skl_sl_id', $removed)
                ->andWhere('skl_skp_id = :task:', array('task' => $this->skp_id))
                ->execute()
                ->delete();

            $labels = array_values($current);

            $log = Activity::log('remove_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->skp_task_project,
                'ta_task_id' => $this->skp_id,
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
                $r->skl_skp_id = $this->skp_id;
                $r->skl_sl_id = $e['sl_id'];
                $r->save();

                $labels[] = array(
                    'sl_id' => $e['sl_id'],
                    'sl_color' => $e['sl_color'],
                    'sl_label' => $e['sl_label']
                );
            }

            $log = Activity::log('add_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->skp_task_project,
                'ta_task_id' => $this->skp_id,
                'ta_data' => json_encode($labels)
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
            $data['su_grade'] = $user->su_grade;
            $data['su_no'] = $user->su_no;

            return $data;
        });
    }

    public function forward() {

    }
}