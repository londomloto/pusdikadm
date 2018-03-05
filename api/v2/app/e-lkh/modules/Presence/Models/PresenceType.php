<?php
namespace App\Presence\Models;

class PresenceType extends \Micro\Model {

    public function getSource() {
        return 'trx_presence_types';
    }

}