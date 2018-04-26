<?php
namespace App\Lkh\Models;

use Micro\Helpers\Date;

class LkhExam extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'lke_lkh_id',
            'App\Lkh\Models\Task',
            'lkh_id',
            array(
                'alias' => 'Task'
            )
        );
    }

    public function getSource() {
        return 'trx_lkh_exams';
    }

    public function hasNotes() {
        $notes = trim((string)$this->lke_notes);
        return ! empty($notes);
    }

    public function getLabel() {
        static $flags;
        if (is_null($flags)) {
            $flags = Lkh::flags();
        }
        $flag = isset($flags[$this->lke_flag]) ? $flags[$this->lke_flag] : NULL;
        return $flag ? $flag['text'] : NULL;
    }

}