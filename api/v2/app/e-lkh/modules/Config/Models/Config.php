<?php
namespace App\Config\Models;

class Config extends \Micro\Model {

    public function getSource() {
        return 'sys_config';
    }

    public static function data() {
        $rows = self::get()->execute();
        $data = array();

        foreach($rows as $row) {
            $data[$row->sc_name] = $row->sc_value;
        }

        return $data;
    }
}