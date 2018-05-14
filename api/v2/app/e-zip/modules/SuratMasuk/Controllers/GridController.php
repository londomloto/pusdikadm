<?php
namespace App\Skp\Controllers;

class GridController extends \Micro\Controller {

    public function findAction() {
        return array(
            'success' => TRUE,
            'data' => array(),
            'total' => 0
        );
    }

}