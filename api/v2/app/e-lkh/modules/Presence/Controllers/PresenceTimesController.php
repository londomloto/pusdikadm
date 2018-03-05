<?php
namespace App\Presence\Controllers;

use App\Presence\Models\Task;

class PresenceTimesController extends \Micro\Controller {

    public function findAction() {
        $query = Task::get()
            ->alias('task')
            ->columns('task.tpr_checkin AS tpr_checkin')
            ->filterable() 
            ->groupBy('task.tpr_checkin')
            ->orderBy('task.tpr_checkin ASC');

        return $query->paginate();
    }

}