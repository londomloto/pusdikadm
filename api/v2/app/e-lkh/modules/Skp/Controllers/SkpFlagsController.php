<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Skp;

class SkpFlagsController extends \Micro\Controller {

    public function findAction() {
        $data = array_values(Skp::flags());

        return array(
            'success' => TRUE,
            'data' => $data,
            'total' => count($data)
        );
    }

}