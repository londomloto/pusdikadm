<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\Lkh;

class LkhFlagsController extends \Micro\Controller {

    public function findAction() {
        $data = array_values(Lkh::flags());

        return array(
            'success' => TRUE,
            'data' => $data,
            'total' => count($data)
        );
    }

}