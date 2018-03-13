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

    public function getNamespace() {
        return '/skp';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            Activity::log('create', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_task_id' => $this->skp_id,
                'ta_sp_id' => $this->skp_task_project,
                'ta_data' => $this->getTitle()
            ));    
        }
    }

    public function afterUpdate() {
        if ($this->__loggable) {
            $snapshot = $this->__snapshot;
            
            if ( ! is_null($snapshot) && ! empty($snapshot['skp_id'])) {
                $detail = TRUE;

                if ($snapshot['skp_task_due'] != $this->skp_task_due) {
                    
                    $detail = FALSE;

                    Activity::log('update_due', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->skp_id,
                        'ta_sp_id' => $this->skp_task_project,
                        'ta_data' => $this->skp_task_due
                    ));
                }

                if ($detail) {

                    Activity::log('update', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->skp_id,
                        'ta_sp_id' => $this->skp_task_project,
                        'ta_data' => $this->getTitle()
                    ));
                }
            }
        }
    }

    public function afterFetch() {
        if (isset($this->skp_id, $this->skp_task_due)) {
            $this->__snapshot = array(
                'skp_id' => $this->skp_id,
                'skp_task_due' => $this->skp_task_due
            );
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

    public function saveLabels($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getLabels() as $e) {
            $current[$e->sl_id] = TRUE;
        }

        foreach($post as $e) {
            if (isset($current[$e['sl_id']])) {
                $updated[] = $e;
                unset($current[$e['sl_id']]);
            } else {
                $created[] = $e;
            }
        }

        $current = array_values(array_keys($current));

        if (count($current) > 0) {
            TaskLabel::get()
                ->inWhere('skl_sl_id', $current)
                ->andWhere('skl_skp_id = :task:', array('task' => $this->skp_id))
                ->execute()
                ->delete();

            Activity::log('remove_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->skp_task_project,
                'ta_task_id' => $this->skp_id,
                'ta_data' => json_encode($current)
            ));
        }

        if (count($created) > 0) {
            $indexes = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->skl_skp_id = $this->skp_id;
                $r->skl_sl_id = $e['sl_id'];
                $r->save();

                $indexes[] = $e['sl_id'];
            }

            Activity::log('add_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->skp_task_project,
                'ta_task_id' => $this->skp_id,
                'ta_data' => json_encode($indexes)
            ));
        }
    }

    public function forward() {

    }
}