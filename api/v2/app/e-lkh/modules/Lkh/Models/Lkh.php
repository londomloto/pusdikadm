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
                'alias' => 'Author'
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

        if ($this->author) {
            $author = $this->author->toArray();
            
            $data['lkh_su_fullname'] = $author['su_fullname'];
            $data['lkh_su_no'] = $author['su_no'];
            $data['lkh_su_grade'] = $author['su_grade'];
            $data['lkh_su_sj_name'] = $author['su_sj_name'];
            $data['lkh_su_sdp_name'] = $author['su_sdp_name'];
            $data['lkh_su_avatar_thumb'] = $author['su_avatar_thumb'];
        }

        if ($this->presence) {
               
        }

        return $data;
    }

    public function getTitle() {
        $title  = $this->author ? $this->author->getName() : '(dihapus)';
        $title .= ' ('.DateHelper::format($this->lkh_date, 'd M Y').')';
        return $title;
    }

    public function saveItems($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->items as $elem) {
            $current[$elem->lki_id] = TRUE;
        }

        foreach($post as $elem) {
            if ( ! isset($elem['lki_id'])) {
                $created[] = $elem;
            } else if (isset($current[$elem['lki_id']])) {
                $updated[] = $elem;
                unset($current[$elem['lki_id']]);
            }
        }

        $current = array_values(array_keys($current));

        if (count($current) > 0) {
            LkhItem::get()->inWhere('lki_id', $current)->execute()->delete();
        }

        if (count($created) > 0) {
            foreach($created as $elem) {
                if ( ! empty($elem['lki_desc'])) {
                    $item = new LkhItem();
                    $elem['lki_lkh_id'] = $this->lkh_id;
                    $item->save($elem);
                }
            }
        }
        
    }

}