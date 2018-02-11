<?php
namespace App\Sender\Models;

class Sender extends \Micro\Model {

    public function getSource() {
        return 'trx_sender';
    }

}