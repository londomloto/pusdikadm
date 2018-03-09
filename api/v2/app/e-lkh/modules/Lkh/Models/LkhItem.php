<?php
namespace App\Lkh\Models;

class LkhItem extends \Micro\Model {

    public function getSource() {
        return 'trx_lkh_items';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['lki_cost_formatted'] = number_format($this->lki_cost, 0, ',', '.');
        return $data;
    }
}