<?php
namespace App\Skp\Controllers;

use App\Behaviors\Models\Behavior;
use App\Skp\Models\SkpBehavior;

class SkpBehaviorsController extends \Micro\Controller {

    public function findAction() {
        $display = $this->request->getQuery('display');

        switch($display) {
            case 'setup':

                $skp = $this->request->getQuery('skp');
                $data = SkpBehavior::fetch($skp);

                return array(
                    'success' => TRUE,
                    'data' => $data
                );
        }
    }

    public function findByIdAction($id) {
        return SkpBehavior::get($id);
    }

}