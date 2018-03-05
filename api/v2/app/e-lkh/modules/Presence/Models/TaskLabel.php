<?php
namespace App\Presence\Models;

class TaskLabel extends \Micro\Model {

    public function getSource() {
        return 'trx_presence_labels';
    }

}