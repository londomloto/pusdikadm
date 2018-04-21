<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\LkhExam;

class LkhExamsController extends \Micro\Controller {

    public function findAction() {
        return LkhExam::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $exam = new LkhExam();

        if ($exam->save($post)) {
            return LkhExam::get($exam->lke_id);
        }

        return LkhExam::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = LkhExam::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $exam = LkhExam::get($id)->data;

        if ($exam) {
            $exam->delete();
        }

        return array(
            'success' => TRUE
        );
    }
}