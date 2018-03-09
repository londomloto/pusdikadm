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
            'lkh_tpr_id',
            'App\Presence\Models\Presence',
            'tpr_id',
            array(
                'alias' => 'Presence',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'lkh_id',
            'App\Lkh\Models\LkhItem',
            'lki_lkh_id',
            array(
                'alias' => 'Items'
            )
        );
    }

    public function getSource() {
        return 'trx_lkh';
    }

    public function beforeSave() {
        if (isset($this->lkh_exam_id) && $this->lkh_exam_id == '') {
            $this->lkh_exam_id = NULL;
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['lkh_title'] = $this->getTitle();
        $data['lkh_date_formatted'] = DateHelper::format($this->lkh_date, 'd M Y');

        if (($user = $this->user)) {
            $data['lkh_su_fullname'] = $user->getName();
            $data['lkh_su_no'] = $user->su_no;
            $data['lkh_su_grade'] = $user->su_grade;
            $data['lkh_su_sj_name'] = $user->job ? $user->job->sj_name : '';
            $data['lkh_su_sdp_name'] = $user->department ? $user->department->sdp_name : '';
            $data['lkh_su_avatar_thumb'] = $user->getAvatarThumb();

        }

        if ($this->presence) {
            $data['lkh_tpr_date_formatted'] = DateHelper::format($this->presence->tpr_date, 'd M Y');
        }

        return $data;
    }

    public function getSortedItems() {
        return $this->getItems(array('orderBy' => 'lki_id DESC'));
    }

    public function getTitle() {
        $user = $this->user;
        $title  = $user ? $user->getName() : '(dihapus)';
        $title .= ' ('.DateHelper::format($this->lkh_date, 'd M Y').')';
        return $title;
    }

    public function saveItems($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->items as $model) {
            $current[$model->lki_id] = $model;
        }

        foreach($post as $item) {
            if ( ! isset($item['lki_id'])) {
                $created[] = $item;
            } else if (isset($current[$item['lki_id']])) {
                $model = $current[$item['lki_id']];
                $model->save($item);
                
                unset($current[$item['lki_id']]);
            }
        }

        if (count($current) > 0) {
            foreach($current as $model) {
                $model->delete();
            }
        }

        if (count($created) > 0) {
            foreach($created as $item) {
                if ( ! empty($item['lki_desc'])) {
                    $model = new LkhItem();
                    $item['lki_lkh_id'] = $this->lkh_id;
                    $model->save($item);
                }
            }
        }

        
    }

}