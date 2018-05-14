<?php
namespace App\Classifications\Models;

class Classification extends \Micro\Model {

    public function getSource() {
        return 'sys_classifications';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray();
        $data['scl_label'] = $data['scl_code'].' - '.$data['scl_name'];
        return $data;
    }
}