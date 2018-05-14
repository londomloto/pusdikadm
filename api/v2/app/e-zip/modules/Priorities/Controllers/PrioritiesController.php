<?php
namespace App\Priorities\Controllers;

use App\Priorities\Models\Priority;

class PrioritiesController extends \Micro\Controller {

    public function findAction() {
        return Priority::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Priority();

        if ($data->save($post)) {
            return Priority::get($data->spt_id);
        }

        return Priority::none();
    }

    public function updateAction($id) {
        $query = Priority::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Priority::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }

}