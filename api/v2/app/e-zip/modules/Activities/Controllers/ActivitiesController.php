<?php
namespace App\Activities\Controllers;

use App\Activities\Models\Activity;

class ActivitiesController extends \Micro\Controller {

    public function findAction() {
        return Activity::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $type = isset($post['ta_type']) ? $post['ta_type'] : 'comment';
        
        // validate message
        $message = strip_tags($post['ta_data']);

        if (empty($message)) {
            return array(
                'success' => FALSE
            );
        }
        
        $log = Activity::log($type, $post);

        if ($log) {
            
            $log->subscribe();
            $log->broadcast();

            return array(
                'success' => TRUE,
                'data' => $log->toArray()
            );
        }

        return array(
            'success' => FALSE
        );
    }

    public function updateAction($id) {
        $query = Activity::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function uploadAction() {
        $success = $this->uploader->initialize(array(
            'path' => APPPATH.'public/resources/attachments/',
            'encrypt' => TRUE
        ))->upload();
        
        if ($success) {
            $result = $this->uploader->getResult();

            if (preg_match('/image/', $result->filetype)) {
                $code = sprintf('[image:%s]', $result->filename);
            } else {
                $code = sprintf('[attachment:%s]', $result->filename);
            }

            return array(
                'success' => TRUE,
                'data' => array(
                    'code' => $code
                )
            );
        } else {
            return array(
                'success' => FALSE,
                'data' => NULL
            );
        }
    }
    
    public function deleteAction($id) {
        $data = Activity::get($id)->data;

        if ($data) {
            $data->delete();
        }
        return array(
            'success' => TRUE
        );
    }
}