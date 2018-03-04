<?php
namespace App\Lkh\Models;

class TaskStatus extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'lks_status',
            'App\Bpmn\Models\Link',
            'id',
            array(
                'alias' => 'Status'
            )
        );

        $this->belongsTo(
            'lks_lkh_id',
            'App\Lkh\Models\Task',
            'lkh_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->belongsTo(
            'lks_status',
            'App\Kanban\Models\KanbanStatus',
            'kst_status',
            array(
                'alias' => 'KanbanStatus'
            )
        );
    }

    public function getSource() {
        return 'trx_lkh_statuses';
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