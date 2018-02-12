<?php
namespace App\Flags\Controllers;

use App\Flags\Models\Flag;

class FlagsController extends \Micro\Controller {

    public function findAction() {
        return Flag::get()->filterable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Flag();

        if ($data->save($post)) {
            return Flag::get($data->tfg_id);
        }

        return Flag::none();
    }

    public function updateAction($id) {
        $query = Flag::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Flag::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }
}