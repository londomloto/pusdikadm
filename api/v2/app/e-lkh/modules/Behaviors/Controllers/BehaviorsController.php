<?php
namespace App\Behaviors\Controllers;

use App\Behaviors\Models\Behavior;

class BehaviorsController extends \Micro\Controller {

    public function findAction() {
        return Behavior::get()->paginate();
    }

}