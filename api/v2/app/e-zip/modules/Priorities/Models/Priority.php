<?php
namespace App\Priorities\Models;

class Priority extends \Micro\Model {

    public function getSource() {
        return 'sys_priorities';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['spt_label'] = $this->getLabel();
        return $data;
    }

    public function getLabel() {
        return $this->spt_name.' ('.$this->spt_code.')';
    }
}