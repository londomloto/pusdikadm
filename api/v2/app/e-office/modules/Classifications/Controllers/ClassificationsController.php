<?php
namespace App\Classifications\Controllers;

use App\Classifications\Models\Classification;

class ClassificationsController extends \Micro\Controller {

    public function findAction() {
        return Classification::get()->filterable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Classification();

        if ($data->save($post)) {
            return Classification::get($data->tcs_id);
        }

        return Classification::none();
    }

    public function updateAction($id) {
        $query = Classification::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Classification::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }
}