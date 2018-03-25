<?php
namespace App\Criteria\Controllers;

use App\Criteria\Models\Criteria;

class CriteriaController extends \Micro\Controller {

    public function findAction() {
        $data = Criteria::get()
            ->orderBy('tcr_max ASC')
            ->execute();

        return array(
            'success' => TRUE,
            'data' => $data->toArray()
        );
    }

}