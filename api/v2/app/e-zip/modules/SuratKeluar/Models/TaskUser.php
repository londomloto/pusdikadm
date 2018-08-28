<?php
namespace App\SuratKeluar\Models;

class TaskUser extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'tsmu_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'User'
            )
        );
    }

    public function getSource() {
        return 'trx_keluar_users';
    }

}