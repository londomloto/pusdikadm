<?php
namespace App\System\Models;

class Constant extends \Micro\Model {

    public function getSource() {
        return 'sys_constants';
    }

    public static function valueOf($name, $default = NULL) {
        static $values;

        if (is_null($values)) {
            $values = array();

            foreach(self::find() as $row) {
                $values[$row->sco_name] = $row->sco_value;
            }
        }

        return isset($values[$name]) ? $values[$name] : $default;
    }
}