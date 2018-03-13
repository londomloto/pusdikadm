<?php
namespace App\Skp\Models;

class SkpItem extends \Micro\Model {

    public function getSource() {
        return 'trx_skp_items';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['ski_text'] = $data['ski_desc'];
        $data['ski_expand'] = FALSE;
        return $data;
    }

}