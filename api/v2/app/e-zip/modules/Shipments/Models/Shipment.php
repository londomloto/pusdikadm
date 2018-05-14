<?php
namespace App\Shipments\Models;

class Shipment extends \Micro\Model {

    public function getSource() {
        return 'sys_shipments';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['sdt_label'] = $this->getLabel();
        return $data;
    }

    public function getLabel() {
        return $this->sdt_name.' ('.$this->sdt_code.')';
    }
}