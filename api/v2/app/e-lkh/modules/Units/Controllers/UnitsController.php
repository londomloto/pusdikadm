<?php
namespace App\Units\Controllers;

use App\Units\Models\Unit;

class UnitsController extends \Micro\Controller {

    public function findAction() {
        return Unit::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $post['sun_name'] = trim($post['sun_name']);

        $data = Unit::findFirst(array(
            'sun_name = :name:',
            'bind' => array(
                'name' => $post['sun_name']
            )
        ));

        if ( ! $data) {
            $data = new Unit();

            if ($data->save($post)) {
                return Unit::get($data->sun_id);
            }

            return Unit::none();
        } else {
            return Unit::get($data->sun_id);
        }
    }

    public function updateAction($id) {
        $query = Unit::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Unit::get($id);

        if ($query->data) {
            return array(
                'success' => $query->data->delete()
            );
        }

        return array('success' => FALSE);
    }
}