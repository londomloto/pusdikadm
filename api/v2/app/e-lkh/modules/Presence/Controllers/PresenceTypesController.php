<?php
namespace App\Presence\Controllers;

use App\Presence\Models\PresenceType;

class PresenceTypesController extends \Micro\Controller {

    public function findAction() {
        return PresenceType::get()->filterable()->paginate();
    }

}