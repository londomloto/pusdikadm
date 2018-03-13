<?php
namespace App\Skp\Models;

class TaskStatus extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'sks_status',
            'App\Bpmn\Models\Link',
            'id',
            array(
                'alias' => 'Status'
            )
        );

        $this->belongsTo(
            'sks_skp_id',
            'App\Skp\Models\Task',
            'skp_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->belongsTo(
            'sks_status',
            'App\Kanban\Models\KanbanStatus',
            'kst_status',
            array(
                'alias' => 'KanbanStatus'
            )
        );
    }

    public function getSource() {
        return 'trx_skp_statuses';
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