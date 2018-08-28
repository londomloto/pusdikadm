<?php
namespace App\System\Models;

class Autonumber extends \Micro\Model {

    public function getSource() {
        return 'sys_numbers';
    }

    public function beforeSave() {
        $this->nulled(array(
            'sn_value',
            'sn_length',
            'sn_monthly',
            'sn_yearly',
            'sn_date'
        ));
    }

    public static function generate($name) {

        $number = self::findFirst(array(
            'sn_name = :name:',
            'bind' => array('name' => $name)
        ));

        if ($number) {

            $value  = $number->sn_value + 1;
            $prefix = (string) $number->sn_prefix;
            $suffix = (string) $number->sn_suffix;

            if ($number->sn_yearly == 1) {
                $used = empty($number->sn_date) ? date('Y') : date('Y', strtotime($number->sn_date));
                $curr = date('Y');
                $sign = date('/Y');

                if ($used != $curr) {
                    $value = 1;
                }

                if (strpos($prefix, $sign) === FALSE) {
                    $suffix .= $sign;
                }
            } else if ($number->sn_monthly == 1) {
                $used = empty($number->sn_date) ? date('Y-m') : date('Y-m', strtotime($number->sn_date));
                $curr = date('Y-m');
                $sign = date('/m/Y');

                if ($used != $curr) {
                    $value = 1;
                }

                if (strpos($prefix, $sign) === FALSE) {
                    $suffix .= $sign;
                }
            }
            
            $length = empty($number->sn_length) ? 1 : $number->sn_length;

            $number->sn_date = date('Y-m-d');
            $number->sn_value = $value;
            $number->save();
            
            $value = str_pad($value, (int)$length, '0', STR_PAD_LEFT);
            $value = $prefix.$value.$suffix;

            return $value;
        }

        return NULL;
    }

}