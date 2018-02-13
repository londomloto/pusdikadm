<?php
namespace App\SuratKeluar\Models;

use Phalcon\Mvc\Model\Relation;

class SuratKeluar extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'tsk_tcs_id',
            'App\Classifications\Models\Classification',
            'tcs_id',
            array(
                'alias' => 'Classification'
            )
        );

        $this->hasMany(
            'tsk_id',
            'App\SuratKeluar\Models\Document',
            'tskd_tsk_id',
            array(
                'alias' => 'Documents',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasOne(
            'tsk_exam1_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Exam1User'
            )
        );

        $this->hasOne(
            'tsk_exam1_flag',
            'App\Flags\Models\Flag',
            'tfg_name',
            array(
                'alias' => 'Exam1Flag'
            )
        );

        $this->hasOne(
            'tsk_exam2_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Exam2User'
            )
        );

        $this->hasOne(
            'tsk_exam2_flag',
            'App\Flags\Models\Flag',
            'tfg_name',
            array(
                'alias' => 'Exam2Flag'
            )
        );

        $this->hasOne(
            'tsk_exam3_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Exam3User'
            )
        );

        $this->hasOne(
            'tsk_exam3_flag',
            'App\Flags\Models\Flag',
            'tfg_name',
            array(
                'alias' => 'Exam3Flag'
            )
        );

        $this->hasOne(
            'tsk_sign_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'SignUser'
            )
        );

    }

    public function getSource() {
        return 'trx_surat_keluar';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsk_code'] = empty($this->tsk_code) ? '-' : $this->tsk_code;
        $data['tsk_date_formatted'] = self::__formatDate($this->tsk_date);
        $data['tsk_create_date_formatted'] = self::__formatDate($this->tsk_create_date);

        if ($this->classification) {
            $data['tsk_tcs_name'] = $this->classification->tcs_name;
            $data['tsk_tcs_label'] = $this->classification->tcs_code.' - '.$this->classification->tcs_name;
        }

        $data['tsk_exam1_date_formatted'] = date('d M Y', strtotime($this->tsk_exam1_date));
        $data['tsk_exam2_date_formatted'] = date('d M Y', strtotime($this->tsk_exam2_date));
        $data['tsk_exam3_date_formatted'] = date('d M Y', strtotime($this->tsk_exam3_date));
        $data['tsk_sign_date_formatted'] = date('d M Y', strtotime($this->tsk_sign_date));
        $data['tsk_send_date_formatted'] = date('d M Y', strtotime($this->tsk_send_date));

        if ($this->exam1User) {
            $data['tsk_exam1_user_name'] = $this->exam1User->getName();
        }

        if ($this->exam1Flag) {
            $data['tsk_exam1_flag_desc'] = $this->exam1Flag->tfg_desc;
        }

        if ($this->exam2User) {
            $data['tsk_exam2_user_name'] = $this->exam2User->getName();
        }

        if ($this->exam2Flag) {
            $data['tsk_exam2_flag_desc'] = $this->exam2Flag->tfg_desc;
        }

        if ($this->exam3User) {
            $data['tsk_exam3_user_name'] = $this->exam3User->getName();
        }

        if ($this->exam3Flag) {
            $data['tsk_exam3_flag_desc'] = $this->exam3Flag->tfg_desc;
        }

        if ($this->signUser) {
            $data['tsk_sign_user_name'] = $this->signUser->getName();
        }

        return $data;
    }

    public function saveDocuments($items) {
        $create = array();
        $remove = array();

        $exists = array();

        foreach($this->documents as $e) {
            $exists[$e->tskd_id] = TRUE;
        }

        foreach($items as $e) {
            if ( ! isset($e['tskd_id'])) {
                $create[] = $e;
            } else {
                unset($exists[$e['tskd_id']]);
            }
        }

        $exists = array_values(array_keys($exists));

        if (count($exists) > 0) {
            Document::get()
                ->inWhere('tskd_id', $exists)
                ->execute()
                ->delete();
        }

        foreach($create as $e) {
            $doc = new Document();
            $e['tskd_tsk_id'] = $this->tsk_id;
            $doc->save($e);
        }
    }

    private static function __formatDate($date) {
        $moment = new \Moment\Moment($date);
        return $moment->format('d M Y');
    }
}