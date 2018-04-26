<?php
namespace App\Skp\Models;

use Micro\Helpers\Date;

class SkpExam extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'ske_skp_id',
            'App\Skp\Models\Task',
            'skp_id',
            array(
                'alias' => 'Task'
            )
        );
    }

    public function getSource() {
        return 'trx_skp_exams';
    }

    public function hasNotes() {
        $notes = trim((string)$this->ske_notes);
        return ! empty($notes);
    }

    public function getLabel() {
        static $flags;

        if (is_null($flags)) {
            $flags = Skp::flags();
        }

        $flag = isset($flags[$this->ske_flag]) ? $flags[$this->ske_flag] : NULL;
        return $flag ? $flag['text'] : NULL;
    }
}