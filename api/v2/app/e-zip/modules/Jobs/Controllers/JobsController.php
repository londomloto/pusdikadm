<?php
namespace App\Jobs\Controllers;

use App\Jobs\Models\Job;
use App\Users\Models\User;

class JobsController extends \Micro\Controller {

    public function findAction() {
        $display = $this->request->getQuery('display');

        switch($display) {
            case 'template':

                $result = Job::get()
                    ->columns(array(
                        'sj_id',
                        'MAX(su_id) AS su_id'
                    ))
                    ->join('App\Users\Models\User', 'sj_id = su_sj_id', '', 'LEFT')
                    ->groupBy('sj_id')
                    ->filterable()
                    ->paginate();

                return $result->filter(function($row){
                    $item = Job::findFirst($row->sj_id)->toArray();
                    $item['su_id'] = $row->su_id;
                    return $item;
                });

            default:
                return Job::get()->filterable()->sortable()->paginate();
        }
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