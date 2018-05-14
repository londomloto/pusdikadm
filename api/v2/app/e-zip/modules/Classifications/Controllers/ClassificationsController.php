<?php
namespace App\Classifications\Controllers;

use App\Classifications\Models\Classification;

class ClassificationsController extends \Micro\Controller {

    public function findAction() {
        $query = Classification::get()
            ->filterable()
            ->sortable();

        if (empty($this->request->getQuery('sort'))) {
            $query->orderBy('scl_code ASC');
        }

        return $query->paginate();

    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Classification();
        if ($data->save($post)) {
            return Classification::get($data->scl_id);
        }
        return Classification::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = Classification::get($id);
        if ($query->data) {
            $query->data->save($post);
        }
        return $query;
    }

    public function deleteAction($id) {
        $data = Classification::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array(
            'success' => $done
        );
    }
}