<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Skp;

class SkpController extends \Micro\Controller {

    public function findAction() {

    }

    public function findByIdAction($id) {
        return Skp::get($id);
    }
    
    public function createAction() {

    }

    // only for update total & performance & behaviors
    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = Skp::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $data = Skp::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array('success' => $done);
    }

    public function saveBehaviorsAction($id) {
        $skp = Skp::get($id)->data;
        if ($skp) {
            $post = $this->request->getJson();
            $skp->saveBehaviors($post['behaviors']);

            return array(
                'success' => TRUE
            );
        }

        return array(
            'success' => FALSE
        );
    }
}