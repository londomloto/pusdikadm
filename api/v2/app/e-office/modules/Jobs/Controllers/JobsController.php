<?php
namespace App\Jobs\Controllers;

use App\Jobs\Models\Job;

class JobsController extends \Micro\Controller {

    public function findAction() {
        return Job::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Job();

        if ($data->save($post)) {
            return Job::get($data->sj_id);
        }

        return Job::none();
    }

    public function updateAction($id) {
        $query = Job::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Job::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }
}