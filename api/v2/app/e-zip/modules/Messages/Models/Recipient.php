<?php
namespace App\Messages\Models;

class Recipient extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'smr_recipient',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Recipient'
            )
        );
    }

    public function getSource() {
        return 'sys_recipients';
    }
}