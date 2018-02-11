<?php
namespace App\Receiver\Controllers;

use App\Receiver\Models\Receiver;

class ReceiverController extends \Micro\Controller {

    public function findAction() {
        return Receiver::get()->filterable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();

        $find = Receiver::findFirst(array(
            'trc_name = :name: AND trc_group = :group:',
            'bind' => array(
                'name' => $post['trc_name'],
                'group' => $post['trc_group']
            )
        ));

        if ($find) {
            return array(
                'success' => TRUE,
                'data' => $find
            );
        } else {
            $data = new Receiver();

            if ($data->save($post)) {
                return Receiver::get($data->trc_id);
            }

            return Receiver::none();
        }
    }
}