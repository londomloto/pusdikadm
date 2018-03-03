<?php
namespace App\Registration\Models;

class TaskStatus extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'tus_status',
            'App\Bpmn\Models\Link',
            'id',
            array(
                'alias' => 'Status'
            )
        );

        $this->belongsTo(
            'tus_su_id',
            'App\Registration\Models\User',
            'su_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->belongsTo(
            'tus_status',
            'App\Kanban\Models\KanbanStatus',
            'kst_status',
            array(
                'alias' => 'KanbanStatus'
            )
        );
    }

    public function getSource() {
        return 'trx_users_statuses';
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