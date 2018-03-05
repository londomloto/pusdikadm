<?php
namespace App\Presence\Controllers;

use App\Presence\Models\Presence;

class PresenceTimesController extends \Micro\Controller {

    public function findAction() {
        $query = Presence::get()
            ->alias('presence')
            ->columns('presence.tpr_checkin AS tpr_checkin')
            ->filterable() 
            ->groupBy('presence.tpr_checkin')
            ->orderBy('presence.tpr_checkin ASC');

        return $query->paginate();
    }

}