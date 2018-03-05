<?php
namespace App\Presence\Models;

class TaskStatus extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'tps_status',
            'App\Bpmn\Models\Link',
            'id',
            array(
                'alias' => 'Status'
            )
        );

        $this->belongsTo(
            'tps_tpr_id',
            'App\Presence\Models\Task',
            'tpr_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->belongsTo(
            'tps_status',
            'App\Kanban\Models\KanbanStatus',
            'kst_status',
            array(
                'alias' => 'KanbanStatus'
            )
        );
    }

    public function getSource() {
        return 'trx_presence_statuses';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['status_text'] = NULL;

        if ($this->status) {
            $data['status_text'] = $this->status->label;
        }


        return $data;
    }
}