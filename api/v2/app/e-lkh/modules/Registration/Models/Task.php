<?php
namespace App\Registration\Models;

use App\Activities\Models\Activity;
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
    }

    public function getNamespace() {
        return '/registration';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            Activity::log('create', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_task_id' => $this->su_id,
                'ta_sp_id' => $this->su_task_project,
                'ta_data' => $this->su_fullname
            ));    
        }
    }

    public function afterUpdate() {
        if ($this->__loggable) {
            $snapshot = $this->__snapshot;

            if ( ! is_null($snapshot) && ! empty($snapshot['su_id'])) {
                $detail = TRUE;

                if ($snapshot['su_task_due'] != $this->su_task_due) {
                    
                    $detail = FALSE;

                    Activity::log('update_due', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->su_id,
                        'ta_sp_id' => $this->su_task_project,
                        'ta_data' => $this->su_task_due
                    ));
                }

                if ($detail) {

                    Activity::log('update', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->su_id,
                        'ta_sp_id' => $this->su_task_project,
                        'ta_data' => $this->su_fullname
                    ));
                }
            }
        }
    }

    public function afterFetch() {
        if (isset($this->su_id, $this->su_task_due)) {
            $this->__snapshot = array(
                'su_id' => $this->su_id,
                'su_task_due' => $this->su_task_due
            );
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['su_task_due_formatted'] = ! empty($this->su_task_due) ? date('d M Y', strtotime($this->su_task_due)) : '';

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

    public function getTitle() {
        return $this->getName();
    }

    public function getLink() {
        $stat = $this->getCurrentStatuses()->getFirst();

        if ($stat) {
            return '/worksheet/'.$this->project->sp_name.'/task/update/'.$stat->tus_id;
        } else {
            return NULL;
        }
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
                ->inWhere('tul_sl_id', $current)
                ->andWhere('tul_su_id = :task:', array('task' => $this->su_id))
                ->execute()
                ->delete();

            Activity::log('remove_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->su_task_project,
                'ta_task_id' => $this->su_id,
                'ta_data' => json_encode($current)
            ));
        }

        if (count($created) > 0) {
            $indexes = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->tul_su_id = $this->su_id;
                $r->tul_sl_id = $e['sl_id'];
                $r->save();

                $indexes[] = $e['sl_id'];
            }

            Activity::log('add_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->su_task_project,
                'ta_task_id' => $this->su_id,
                'ta_data' => json_encode($indexes)
            ));
        }
    }

}