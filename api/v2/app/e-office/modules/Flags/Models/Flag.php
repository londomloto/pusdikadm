<?php
namespace App\Flags\Models;

class Flag extends \Micro\Model {

    public function getSource() {
        return 'trx_flags';
    }

}