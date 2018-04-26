<?php
namespace App\Registration\Models;

class TaskUser extends \Micro\Model {

    public function getSource() {
        return 'trx_users_users';
    }

}