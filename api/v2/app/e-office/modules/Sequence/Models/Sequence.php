<?php
namespace App\Sequence\Models;

class Sequence extends \Micro\Model {

    public function getSource() {
        return 'trx_sequence';
    }

    public static function nextval($type) {
        $data = self::findFirst(array(
            'tsq_type = :type:',
            'bind' => array('type' => $type),
            'orderBy' => 'tsq_id DESC'
        ));

        $value = 1;

        if ( ! $data) {
            $data = new Sequence();
            $data->tsq_type = $type;
            $data->tsq_value = $value;
            $data->save();
        } else {
            $value = ($value + $data->tsq_value);
            $data->tsq_value = $value;
            $data->save();
        }

        return $value;
    }
}