<?php
namespace App\Users\Models;

class UserToken extends \Micro\Model {

    public function getSource() {
        return 'sys_users_tokens';
    }

}