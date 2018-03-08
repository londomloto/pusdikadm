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

    public function getNamespace() {
        return '/lkh';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            Activity::log('create', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_task_id' => $this->lkh_id,
                'ta_sp_id' => $this->lkh_task_project,
                'ta_data' => $this->getTitle()
            ));    
        }
    }

    public function afterUpdate() {
        if ($this->__loggable) {
            $snapshot = $this->__snapshot;
            
            if ( ! is_null($snapshot) && ! empty($snapshot['lkh_id'])) {
                $detail = TRUE;

                if ($snapshot['lkh_task_due'] != $this->lkh_task_due) {
                    
                    $detail = FALSE;

                    Activity::log('update_due', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->lkh_id,
                        'ta_sp_id' => $this->lkh_task_project,
                        'ta_data' => $this->lkh_task_due
                    ));
                }

                if ($detail) {

                    Activity::log('update', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->lkh_id,
                        'ta_sp_id' => $this->lkh_task_project,
                        'ta_data' => $this->getTitle()
                    ));
                }
            }
        }
    }

    public function afterFetch() {
        if (isset($this->lkh_id, $this->lkh_task_due)) {
            $this->__snapshot = array(
                'lkh_id' => $this->lkh_id,
                'lkh_task_due' => $this->lkh_task_due
            );
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['lkh_task_due_formatted'] = DateHelper::format($this->lkh_task_due);
        $data['lkh_created_dt_relative'] = DateHelper::formatRelative($this->lkh_created_dt);

        if ($this->creator) {
            $data['creator_su_fullname'] = $this->creator->getName();
            $data['creator_sr_name'] = $this->creator->role ? $this->creator->role->sr_name : '';
            $data['creator_su_avatar_thumb'] = $this->creator->getAvatarThumb();
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
            return '/worksheet/'.$this->project->sp_name.'/task/update/'.$stat->lks_id;
        } else {
            return NULL;
        }
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
                ->inWhere('lkl_sl_id', $current)
                ->andWhere('lkl_lkh_id = :task:', array('task' => $this->lkh_id))
                ->execute()
                ->delete();

            Activity::log('remove_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->lkh_task_project,
                'ta_task_id' => $this->lkh_id,
                'ta_data' => json_encode($current)
            ));
        }

        if (count($created) > 0) {
            $indexes = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->lkl_lkh_id = $this->lkh_id;
                $r->lkl_sl_id = $e['sl_id'];
                $r->save();

                $indexes[] = $e['sl_id'];
            }

            Activity::log('add_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->lkh_task_project,
                'ta_task_id' => $this->lkh_id,
                'ta_data' => json_encode($indexes)
            ));
        }
    }

    public function forward() {

    }
}