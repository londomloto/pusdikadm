<?php
namespace App\Lkh\Models;

use Micro\Helpers\Date as DateHelper;

class Lkh extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'lkh_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'User'
            )
        );

        $this->hasOne(
            'lkh_examiner',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Examiner'
            )
        );

        $this->hasOne(
            'lkh_superior',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Superior'
            )
        );

        $this->hasMany(
            'lkh_id',
            'App\Lkh\Models\LkhDay',
            'lkd_lkh_id',
            array(
                'alias' => 'Days',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_lkh';
    }

    public function beforeSave() {
        if (isset($this->lkh_examiner) && $this->lkh_examiner == '') {
            $this->lkh_examiner = NULL;
        }

        if (isset($this->lkh_superior) && $this->lkh_superior == '') {
            $this->lkh_superior = NULL;
        }

        // create period
        if (isset($this->lkh_start_date, $this->lkh_end_date)) {
            $this->lkh_period = DateHelper::formatPeriod($this->lkh_start_date, $this->lkh_end_date);
        }
        
    }
    
    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        $data['lkh_title'] = $this->getTitle();
        $data['lkh_start_date_formatted'] = DateHelper::format($this->lkh_start_date, 'd M Y');
        $data['lkh_end_date_formatted'] = DateHelper::format($this->lkh_end_date, 'd M Y');

        if (($user = $this->user)) {
            $data['lkh_su_fullname'] = $user->getName();
            $data['lkh_su_no'] = $user->su_no;
            $data['lkh_su_grade'] = $user->su_grade;
            $data['lkh_su_sj_name'] = $user->job ? $user->job->sj_name : '';
            $data['lkh_su_sdp_name'] = $user->department ? $user->department->sdp_name : '';
            $data['lkh_su_avatar_thumb'] = $user->getAvatarThumb();
        }

        if (($examiner = $this->examiner)) {
            $data['examiner_su_fullname'] = $examiner->getName();
            $data['examiner_su_no'] = $examiner->su_no;
            $data['examiner_su_grade'] = $examiner->su_grade;
            $data['examiner_su_sj_name'] = $examiner->job ? $examiner->job->sj_name : '';
            $data['examiner_su_sdp_name'] = $examiner->department ? $examiner->department->sdp_name : '';
            $data['examiner_su_avatar_thumb'] = $examiner->getAvatarThumb();
        }

        if (($superior = $this->superior)) {
            $data['superior_su_fullname'] = $superior->getName();
            $data['superior_su_no'] = $superior->su_no;
            $data['superior_su_grade'] = $superior->su_grade;
            $data['superior_su_sj_name'] = $superior->job ? $superior->job->sj_name : '';
            $data['superior_su_sdp_name'] = $superior->department ? $superior->department->sdp_name : '';
            $data['superior_su_avatar_thumb'] = $superior->getAvatarThumb();
        }

        $auth = \Micro\App::getDefault()->auth->user();
        $data['lkh_authorized'] = FALSE;

        if ($auth['su_id'] == $this->lkh_su_id || $auth['su_id'] == $this->lkh_created_by) {
            $data['lkh_authorized'] = TRUE;
        }

        return $data;
    }

    public function getTitle() {
        $user = $this->user;
        return sprintf('%s (%s)', $user ? $user->getName() : '(dihapus)', $this->lkh_period);
    }

    public function getSampleItems() {
        return array();
    }

}