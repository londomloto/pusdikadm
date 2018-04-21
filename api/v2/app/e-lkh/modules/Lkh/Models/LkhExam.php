<?php
namespace App\Lkh\Models;

use Micro\Helpers\Date;

class LkhExam extends \Micro\Model {

    public function initialize() {

        $this->hasOne(
            'lke_examiner',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Examiner'
            )
        );
    }

    public function getSource() {
        return 'trx_lkh_exams';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        $data['lke_flag_label'] = self::__getFlagLabel($data['lke_flag']);
        $data['lke_date_formatted'] = Date::format($this->lke_date, 'd M Y');
        $data['lke_has_notes'] = !empty(trim($data['lke_notes']));

        $data['examiner_su_fullname'] = NULL;

        if (($examiner = $this->examiner)) {
            $data['examiner_su_fullname'] = $examiner->getName();
        }

        return $data;
    }

    private static function __getFlagLabel($name) {
        static $flags;
        
        if (is_null($flags)) {
            $flags = Lkh::flags();
        }

        if ( ! empty($name) && isset($flags[$name])) {
            return $flags[$name]['text'];
        }

        return NULL;
    }

}