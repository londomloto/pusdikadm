<?php
namespace App\Skp\Controllers;

class DashboardController extends \Micro\Controller {

    public function saveAction() {
        $data = array();

        if ($this->request->hasFiles()) {
            $random = $this->security->getRandom();

            foreach($this->request->getFiles() as $index => $file) {
                $name = str_replace('-', '', $random->uuid()).'.jpg';
                $save = PUBPATH.'resources/charts/'.$name;

                if (@$file->moveTo($save)) {
                    $data[] = $name;
                }
            }
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

}