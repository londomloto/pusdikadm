<?php
namespace App\Categories\Models;

class Category extends \Micro\Model {

    public function getSource() {
        return 'sys_categories';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray();
        $data['sct_label'] = $this->getLabel();
        return $data;
    }

    public function getLabel() {
        return $this->sct_name.' ('.$this->sct_code.')';
    }
}