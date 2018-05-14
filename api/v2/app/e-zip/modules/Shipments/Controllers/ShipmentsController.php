<?php
namespace App\Shipments\Controllers;

use App\Shipments\Models\Shipment;

class ShipmentsController extends \Micro\Controller {

    public function findAction() {
        return Shipment::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Shipment();

        if ($data->save($post)) {
            return Shipment::get($data->sdt_id);
        }

        return Shipment::none();
    }

    public function updateAction($id) {
        $query = Shipment::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Shipment::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }

}