<?php
namespace App\SuratKeluar\Models;

use Micro\Helpers\Date;

class SuratKeluarExam extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'tske_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Examiner'
            )
        );
    }

    public function getSource() {
        return 'trx_keluar_exams';
    }

    public function beforeSave() {
        $this->nulled(array(
            'tske_date',
            'tske_user'
        ));
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tske_date_formatted'] = Date::format($this->tske_date, 'd M Y');
        $data['tske_result'] = $this->getExamResult();
        $data['tske_signature_url'] = $this->getSignatureUrl();
        $data['tske_signature_thumb'] = $this->getSignatureThumb();

        if (($examiner = $this->examiner)) {
            $data['examiner_su_fullname'] = $examiner->getName();
            $data['examiner_su_sj_name'] = $examiner->getJobName();
        }

        return $data;
    }

    public function getSignature() {
        static $signatures = array();

        if ( ! isset($signatures[$this->tske_id])) {
            $sign = $this->tske_signature;
            if (empty($sign)) {
                if (($examiner = $this->examiner)) {
                    $sign = $examiner->su_signature;
                }
            }
            $signatures[$this->tske_id] = $sign;
        }
        
        return $signatures[$this->tske_id];
    }

    public function getSignatureUrl() {
        $sign = $this->getSignature();
        if ( ! empty($sign)) {
            return \Micro\App::getDefault()->url->getBaseUrl().'public/resources/signatures/'.$sign;
        }
        return '';
    }

    public function getSignatureThumb() {
        $sign = $this->getSignature();
        if ( ! empty($sign)) {
            return \Micro\App::getDefault()->url->getSiteUrl('assets/thumb').'?s=public/resources/signatures/'.$sign;
        }
        return '';
    }

    public function getExamResult() {
        $result = '';
        switch($this->tske_flag) {
            case 'APPROVED':
                $result = 'Konsep Disetujui';
                break;
            case 'REVISION':
                $result = 'Revisi Konsep';
        }

        if ( ! empty($this->tske_notes)) {
            $result .= ' ('.$this->tske_notes.')';
        }
        return $result;
    }
}