<?php
namespace App\Classifications\Models;

class Classification extends \Micro\Model {

    public function getSource() {
        return 'trx_classifications';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray();
        $data['tcs_label'] = $data['tcs_code'].' - '.$data['tcs_name'];
        return $data;
    }
}