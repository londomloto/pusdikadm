<?php
namespace App\Secrecy\Controllers;

use App\Secrecy\Models\Secrecy;

class SecrecyController extends \Micro\Controller {

    public function findAction() {
        return Secrecy::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Secrecy();

        if ($data->save($post)) {
            return Secrecy::get($data->sst_id);
        }

        return Secrecy::none();
    }

    public function updateAction($id) {
        $query = Secrecy::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Secrecy::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }

}