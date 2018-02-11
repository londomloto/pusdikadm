<?php
namespace App\Receiver\Models;

class Receiver extends \Micro\Model {

    public function getSource() {
        return 'trx_receiver';
    }

}