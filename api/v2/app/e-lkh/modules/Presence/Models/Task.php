<?php
namespace App\Presence\Models;

use App\Activities\Models\Activity;
use Micro\Helpers\Date as DateHelper;
use Phalcon\Mvc\Model\Relation;

class Task extends Presence implements \App\Tasks\Interfaces\TaskModel {
    
    private $__loggable = TRUE;
    private $__snapshot = NULL;
    
    public function initialize() {
        parent::initialize();

        $this->hasMany(
            'tpr_id',
            'App\Presence\Models\TaskStatus',
            'tps_tpr_id',
            array(
                'alias' => 'Statuses',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'tpr_id',
            'App\Presence\Models\TaskLabel',
            'tpl_tpr_id',
            array(
                'alias' => 'TaskLabels',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'tpr_id',
            'App\Presence\Models\TaskLabel',
            'tpl_tpr_id',
            'tpl_sl_id',
            'App\Labels\Models\Label',
            'sl_id',
            array(
                'alias' => 'Labels'
            )
        );

        $this->hasOne(
            'tpr_created_by',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->belongsTo(
            'tpr_task_project',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Project'
            )
        );
    }

    public function getScope() {
        return 'presence';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            $log = Activity::log('create', array(
                'ta_task_ns' => $this->getScope(),
                'ta_task_id' => $this->tpr_id,
                'ta_sp_id' => $this->tpr_task_project
            ));    

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['tpr_icon'] = $this->getIcon();
        
        
        $data['tpr_task_due_formatted'] = DateHelper::format($this->tpr_task_due, 'd M Y');
        $data['tpr_created_dt_relative'] = DateHelper::formatRelative($this->tpr_created_dt);

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
            return '/worksheet/'.$this->project->sp_name.'/task/update/'.$stat->tps_id;
        } else {
            return NULL;
        }
    }

    public function getCurrentStatuses() {
        return $this->getStatuses(array(
            'conditions' => 'tps_deleted = 0',
            'orderBy' => 'tps_created DESC'
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
                ->inWhere('tpl_sl_id', $removed)
                ->andWhere('tpl_tpr_id = :task:', array('task' => $this->tpr_id))
                ->execute()
                ->delete();

            $labels = array_values($current);

            Activity::log('remove_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->tpr_task_project,
                'ta_task_id' => $this->tpr_id,
                'ta_data' => json_encode($labels)
            ));
        }

        if (count($created) > 0) {
            $labels = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->tpl_tpr_id = $this->tpr_id;
                $r->tpl_sl_id = $e['sl_id'];
                $r->save();

                $labels[] = array(
                    'sl_id' => $e['sl_id'],
                    'sl_color' => $e['sl_color'],
                    'sl_label' => $e['sl_label']
                );
            }

            Activity::log('add_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->tpr_task_project,
                'ta_task_id' => $this->tpr_id,
                'ta_data' => json_encode($labels)
            ));
        }
    }

    public function forward() {

    }
}