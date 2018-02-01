<?php
namespace App\Skp\Models;

class Skp extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'skp_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->hasMany(
            'skp_id',
            'App\Skp\Models\Item',
            'ski_skp_id',
            array(
                'alias' => 'Items'
            )
        );
    }

    public function getSource() {
        return 'trx_skp';
    }

    public function beforeSave() {
        if (isset($this->skp_exam_id) && $this->skp_exam_id == '') {
            $this->skp_exam_id = NULL;
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['skp_date_formatted'] = date('d M Y', strtotime($this->skp_date));


        if ($this->creator) {
            $creator = $this->creator->toArray();
            
            $data['skp_su_fullname'] = $creator['su_fullname'];
            $data['skp_su_no'] = $creator['su_no'];
            $data['skp_su_grade'] = $creator['su_grade'];
            $data['skp_su_sj_name'] = $creator['su_sj_name'];
            $data['skp_su_sdp_name'] = $creator['su_sdp_name'];
        }

        $data['items'] = array();

        foreach($this->items as $item) {
            $data['items'][] = $item->toArray();
        }

        return $data;
    }

    public function saveItems($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->items as $elem) {
            $current[$elem->ski_id] = TRUE;
        }

        foreach($post as $elem) {
            if ( ! isset($elem['ski_id'])) {
                $created[] = $elem;
            } else if (isset($current[$elem['ski_id']])) {
                $updated[] = $elem;
                unset($current[$elem['ski_id']]);
            }
        }

        $current = array_values(array_keys($current));

        if (count($current) > 0) {
            Item::get()->inWhere('ski_id', $current)->execute()->delete();
        }

        if (count($created) > 0) {
            foreach($created as $elem) {
                if ( ! empty($elem['ski_desc'])) {
                    $item = new Item();
                    $elem['ski_skp_id'] = $this->skp_id;
                    $item->save($elem);
                }
            }
        }
        
    }

}