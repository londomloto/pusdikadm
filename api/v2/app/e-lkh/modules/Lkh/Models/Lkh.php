<?php
namespace App\Lkh\Models;

class Lkh extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'lkh_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
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
            'App\Lkh\Models\Item',
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
        $data['lkh_date_formatted'] = date('d M Y', strtotime($this->lkh_date));

        $data['lkh_is_validating'] = $this->lkh_validation == 0;
        
        $data['lkh_is_approved'] = $this->lkh_validation == 1;
        $data['lkh_is_rejected'] = $this->lkh_validation == 2;
        $data['lkh_is_revision'] = $this->lkh_validation == 3;


        if ($this->creator) {
            $creator = $this->creator->toArray();
            
            $data['lkh_su_fullname'] = $creator['su_fullname'];
            $data['lkh_su_no'] = $creator['su_no'];
            $data['lkh_su_grade'] = $creator['su_grade'];
            $data['lkh_su_sj_name'] = $creator['su_sj_name'];
            $data['lkh_su_sdp_name'] = $creator['su_sdp_name'];
        }

        if ($this->presence) {
            $presence = $this->presence->toArray();

            foreach($presence as $key => $val) {
                $data['lkh_'.$key] = $val;
            }
        }

        $data['items'] = array();

        foreach($this->items as $item) {
            $data['items'][] = $item->toArray();
        }

        return $data;
    }

    public static function dbcreate($data = array()) {
        $model = new Lkh();

        if ($model->save($data)) {
            return $model->get($model->lkh_id);
        }

        return self::none();
    }

    public static function dbupdate($id, $data = array()) {
        $query = self::get($id);

        if ($query->data) {
            $query->data->save($data);
        }

        return $query;
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
            Item::get()->inWhere('lki_id', $current)->execute()->delete();
        }

        if (count($created) > 0) {
            foreach($created as $elem) {
                if ( ! empty($elem['lki_desc'])) {
                    $item = new Item();
                    $elem['lki_lkh_id'] = $this->lkh_id;
                    $item->save($elem);
                }
            }
        }
        
    }

}