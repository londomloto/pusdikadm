<?php
namespace App\Secrecy\Models;

class Secrecy extends \Micro\Model {

    public function getSource() {
        return 'sys_secrecy';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['sst_label'] = $this->getLabel();
        return $data;
    }

    public function getLabel() {
        return $this->sst_name.' ('.$this->sst_code.')';
    }
}