<?php
namespace App\Jobs\Controllers;

use App\Jobs\Models\Job;

class JobsController extends \Micro\Controller {

    public function findAction() {
        return Job::get()->filterable()->sortable()->paginate();
    }

    public function subordinatesAction($id) {
        $job = Job::get($id)->data;
        
        if ($job) {
            return $job->fetchSubordinates();
        }
        
        return array(
            'success' => FALSE,
            'data' => array()
        );
    }

    public function createAction() {
        $post = $this->request->getJson();
        
        if (empty($post['sj_acronym'])) {
            $post['sj_acronym'] = $post['sj_name'];
        }

        $data = new Job();

        if ($data->save($post)) {
            $data->setupDisposition();
            return Job::get($data->sj_id);
        }

        return Job::none();
    }

    public function updateAction($id) {
        $query = Job::get($id);
        $post = $this->request->getJson();

        if (empty($post['sj_acronym'])) {
            $post['sj_acronym'] = $post['sj_name'];
        }

        if ($query->data) {
            if ($query->data->save($post)) {
                $query->data->setupDisposition();
            }
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