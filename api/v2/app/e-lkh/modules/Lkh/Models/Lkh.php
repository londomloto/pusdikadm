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
    }

    public function getSource() {
        return 'trx_lkh';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['lkh_date_formatted'] = date('d M Y', strtotime($this->lkh_date));

        if ($this->creator) {
            $creator = $this->creator->toArray();
            $data['lkh_su_fullname'] = $creator['su_fullname'];
            $data['lkh_su_sj_name'] = $creator['su_sj_name'];
            $data['lkh_su_sdp_name'] = $creator['su_sdp_name'];
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
}