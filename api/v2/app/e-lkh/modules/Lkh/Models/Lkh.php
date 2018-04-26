<?php
namespace App\Lkh\Models;

use Micro\Helpers\Date as Date;

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
            'lkh_evaluator',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Evaluator'
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

        $this->hasMany(
            'lkh_id',
            'App\Lkh\Models\LkhExam',
            'lke_lkh_id',
            array(
                'alias' => 'Exams',
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

        if (isset($this->lkh_evaluator) && $this->lkh_evaluator == '') {
            $this->lkh_evaluator = NULL;
        }

        // create period
        if (isset($this->lkh_start_date, $this->lkh_end_date)) {
            $this->lkh_period = Date::formatPeriod($this->lkh_start_date, $this->lkh_end_date);
        }
        
    }
    
    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        $data['lkh_title'] = $this->getTitle();
        $data['lkh_start_date_formatted'] = Date::format($this->lkh_start_date, 'd M Y');
        $data['lkh_end_date_formatted'] = Date::format($this->lkh_end_date, 'd M Y');

        if (($user = $this->user)) {
            $data['lkh_su_fullname'] = $user->getName();
            $data['lkh_su_no'] = $user->su_no;
            $data['lkh_su_sg_name'] = $user->getGradeName();
            $data['lkh_su_sj_name'] = $user->job ? $user->job->sj_name : '';
            $data['lkh_su_sdp_name'] = $user->department ? $user->department->sdp_name : '';
            $data['lkh_su_avatar_thumb'] = $user->getAvatarThumb();
        }

        if (($examiner = $this->examiner)) {
            $data['examiner_su_fullname'] = $examiner->getName();
            $data['examiner_su_no'] = $examiner->su_no;
            $data['examiner_su_sg_name'] = $examiner->getGradeName();
            $data['examiner_su_sj_name'] = $examiner->job ? $examiner->job->sj_name : '';
            $data['examiner_su_sdp_name'] = $examiner->department ? $examiner->department->sdp_name : '';
            $data['examiner_su_avatar_thumb'] = $examiner->getAvatarThumb();
        }

        if (($evaluator = $this->evaluator)) {
            $data['evaluator_su_fullname'] = $evaluator->getName();
            $data['evaluator_su_no'] = $evaluator->su_no;
            $data['evaluator_su_sg_name'] = $evaluator->getGradeName();
            $data['evaluator_su_sj_name'] = $evaluator->job ? $evaluator->job->sj_name : '';
            $data['evaluator_su_sdp_name'] = $evaluator->department ? $evaluator->department->sdp_name : '';
            $data['evaluator_su_avatar_thumb'] = $evaluator->getAvatarThumb();
        }
        
        return $data;
    }

    public function getTitle() {
        $user = $this->user;
        return sprintf('%s (%s)', $user ? $user->getName() : '(dihapus)', $this->lkh_period);
    }

    public function fetchItems() {
        $query = LkhItem::get()
            ->alias('lki')
            ->columns(array(
                'lki.lki_id',
                'lki.lki_desc',
                'lki.lki_volume',
                'lki.lki_unit',
                'lki.lki_cost',
                'lkd.lkd_date AS lki_lkd_date'
            ))
            ->join('App\Lkh\Models\LkhDay', 'lkd.lkd_id = lki.lki_lkd_id', 'lkd', 'LEFT')
            ->andWhere('lkd.lkd_lkh_id = :lkh:', array('lkh' => $this->lkh_id))
            ->orderBy('lkd.lkd_date');

        $token = NULL;
        $index = 1;

        $result = $query->execute()->filter(function($row) use (&$token, &$index){

            $item = array(
                'lki_index' => $index,
                'lki_group' => NULL,
                'lki_id' => $row->lki_id,
                'lki_desc' => $row->lki_desc,
                'lki_volume' => $row->lki_volume,
                'lki_unit' => $row->lki_unit,
                'lki_cost' => $row->lki_cost,
                'lki_cost_formatted' => '',
                'lki_lkd_date' => $row->lki_lkd_date,
                'lki_lkd_date_formatted' => Date::format($row->lki_lkd_date, 'd M Y')
            );

            if ( ! is_null($row->lki_cost)) {
                $item['lki_cost_formatted'] = number_format($row->lki_cost, 0, ',', '.');
            }

            if ($token != $row->lki_lkd_date) {
                $item['lki_group'] = date('d', strtotime($row->lki_lkd_date));
                $index++;
            } else {
                $item['lki_index'] = NULL;
            }
            
            $token = $row->lki_lkd_date;

            return $item;
        });



        return $result;
    }

    public static function flags() {

        return array(
            'EXAM' => array(
                'name' => 'EXAM',
                'text' => 'Tidak ada tindakan'
            ),
            'TODO' => array(
                'name' => 'TODO',
                'text' => 'Dikembalikan ke tahap pembuatan'
            ),
            'DONE' => array(
                'name' => 'DONE',
                'text' => 'Diteruskan ke tahap pengesahan'
            )
        );

    }
}