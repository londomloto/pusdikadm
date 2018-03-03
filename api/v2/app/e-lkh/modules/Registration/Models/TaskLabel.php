<?php
namespace App\Registration\Models;

class TaskLabel extends \Micro\Model {

    public function getSource() {
        return 'trx_users_labels';
    }

}