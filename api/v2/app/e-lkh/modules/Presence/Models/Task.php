<?php
namespace App\Presence\Models;

use App\Activities\Models\Activity;
use Micro\Helpers\Date as DateHelper;
use Phalcon\Mvc\Model\Relation;

class Task extends \Micro\Model implements \App\Tasks\Interfaces\TaskModel {
    
    private $__loggable = TRUE;
    private $__snapshot = NULL;
    
    public function initialize() {

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
            'tpr_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Author'
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

    public function getSource() {
        return 'trx_presence';
    }

    public function getNamespace() {
        return '/presence';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            Activity::log('create', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_task_id' => $this->tpr_id,
                'ta_sp_id' => $this->tpr_task_project,
                'ta_data' => $this->getTitle()
            ));    
        }
    }

    public function afterUpdate() {
        if ($this->__loggable) {
            $snapshot = $this->__snapshot;
            
            if ( ! is_null($snapshot) && ! empty($snapshot['tpr_id'])) {
                $detail = TRUE;

                if ($snapshot['tpr_task_due'] != $this->tpr_task_due) {
                    
                    $detail = FALSE;

                    Activity::log('update_due', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->tpr_id,
                        'ta_sp_id' => $this->tpr_task_project,
                        'ta_data' => $this->tpr_task_due
                    ));
                }

                if ($detail) {

                    Activity::log('update', array(
                        'ta_task_ns' => $this->getNamespace(),
                        'ta_task_id' => $this->tpr_id,
                        'ta_sp_id' => $this->tpr_task_project,
                        'ta_data' => $this->getTitle()
                    ));
                }
            }
        }
    }

    public function afterFetch() {
        if (isset($this->tpr_id, $this->tpr_task_due)) {
            $this->__snapshot = array(
                'tpr_id' => $this->tpr_id,
                'tpr_task_due' => $this->tpr_task_due
            );
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['tpr_icon'] = $this->getIcon();
        $data['tpr_title'] = $this->getTitle();
        $data['tpr_date_formatted'] = DateHelper::format($this->tpr_date, 'd M Y');
        $data['tpr_task_due_formatted'] = DateHelper::format($this->tpr_task_due, 'd M Y');
        $data['tpr_created_dt_relative'] = DateHelper::formatRelative($this->tpr_created_dt);

        if ($this->author) {
            $data['tpr_su_fullname'] = $this->author->getName();
            $data['tpr_su_sj_name'] = $this->author->job ? $this->author->job->sj_name : '';
            $data['tpr_su_sdp_name'] = $this->author->department ? $this->author->department->sdp_name : '';
        }

        if ($this->creator) {
            $data['creator_su_fullname'] = $this->creator->getName();
            $data['creator_sr_name'] = $this->creator->role ? $this->creator->role->sr_name : '';
            $data['creator_su_avatar_thumb'] = $this->creator->getAvatarThumb();
        }

        $data['tpr_has_file'] = !empty($this->tpr_filename);
        $data['tpr_has_time'] = $this->tpr_type == 'Masuk';

        return $data;
    }

    public function suspendLog() {
        $this->__loggable = FALSE;
    }

    public function resumeLog() {
        $this->__loggable = TRUE;
    }

    public function getIcon() {
        switch($this->tpr_type) {
            case 'Masuk':
                return 'social:mood';
            default:
                return 'social:mood';
        }
    }

    public function getTitle() {
        $title  = $this->author ? $this->author->getName() : '(dihapus)';
        $title .= ' - '.DateHelper::format($this->tpr_date, 'd M Y');
        return $title;
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
                ->inWhere('tpl_sl_id', $current)
                ->andWhere('tpl_tpr_id = :task:', array('task' => $this->tpr_id))
                ->execute()
                ->delete();

            Activity::log('remove_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->tpr_task_project,
                'ta_task_id' => $this->tpr_id,
                'ta_data' => json_encode($current)
            ));
        }

        if (count($created) > 0) {
            $indexes = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->tpl_tpr_id = $this->tpr_id;
                $r->tpl_sl_id = $e['sl_id'];
                $r->save();

                $indexes[] = $e['sl_id'];
            }

            Activity::log('add_label', array(
                'ta_task_ns' => $this->getNamespace(),
                'ta_sp_id' => $this->tpr_task_project,
                'ta_task_id' => $this->tpr_id,
                'ta_data' => json_encode($indexes)
            ));
        }
    }

    public function forward() {

    }
}