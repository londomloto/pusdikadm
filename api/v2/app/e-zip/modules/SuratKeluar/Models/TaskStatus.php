<?php
namespace App\SuratKeluar\Models;

class TaskStatus extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'tsks_status',
            'App\Bpmn\Models\Link',
            'id',
            array(
                'alias' => 'Status'
            )
        );

        $this->belongsTo(
            'tsks_tsm_id',
            'App\SuratKeluar\Models\Task',
            'tsm_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->belongsTo(
            'tsks_status',
            'App\Kanban\Models\KanbanStatus',
            'kst_status',
            array(
                'alias' => 'KanbanStatus'
            )
        );
    }

    public function getSource() {
        return 'trx_keluar_statuses';
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