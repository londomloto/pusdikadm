<?php
namespace App\Instructions\Controllers;

use App\Instructions\Models\Instruction;

class InstructionsController extends \Micro\Controller {

    public function findAction() {
        return Instruction::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Instruction();

        if ($data->save($post)) {
            return Instruction::get($data->sin_id);
        }

        return Instruction::none();
    }

    public function updateAction($id) {
        $query = Instruction::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Instruction::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }

}