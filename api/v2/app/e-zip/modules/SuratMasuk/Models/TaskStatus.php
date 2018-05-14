<?php
namespace App\SuratMasuk\Models;

class TaskStatus extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'tsms_status',
            'App\Bpmn\Models\Link',
            'id',
            array(
                'alias' => 'Status'
            )
        );

        $this->belongsTo(
            'tsms_tsm_id',
            'App\SuratMasuk\Models\Task',
            'tsm_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->belongsTo(
            'tsms_status',
            'App\Kanban\Models\KanbanStatus',
            'kst_status',
            array(
                'alias' => 'KanbanStatus'
            )
        );
    }

    public function getSource() {
        return 'trx_masuk_statuses';
    }

    public function getLabel() {
        if (($status = $this->status)) {
            return $status->label;
        }
        return '';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['status_text'] = $this->getLabel();
        
        return $data;
    }
}