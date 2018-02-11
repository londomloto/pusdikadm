<?php
namespace App\Sender\Controllers;

use App\Sender\Models\Sender;

class SenderController extends \Micro\Controller {

    public function findAction() {
        return Sender::get()->filterable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();

        $find = Sender::findFirst(array(
            'tsn_name = :name: AND tsn_group = :group:',
            'bind' => array(
                'name' => $post['tsn_name'],
                'group' => $post['tsn_group']
            )
        ));

        if ($find) {
            return array(
                'success' => TRUE,
                'data' => $find
            );
        } else {
            $data = new Sender();

            if ($data->save($post)) {
                return Sender::get($data->tsn_id);
            }

            return Sender::none();
        }
    }
}