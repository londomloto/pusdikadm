<?php
namespace App\Items\Models;

class Item extends \Micro\Model {

    public function getSource() {
        return 'trx_items';
    }

}