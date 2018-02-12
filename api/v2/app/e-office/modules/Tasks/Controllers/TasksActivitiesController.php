<?php
namespace App\Tasks\Controllers;

use App\Tasks\Models\TaskActivity;

class TasksActivitiesController extends \Micro\Controller {

    public function findAction() {
        return TaskActivity::get()
            ->filterable()
            ->sortable()
            ->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $type = isset($post['tta_type']) ? $post['tta_type'] : 'comment';

        return TaskActivity::log($type, $post);
    }

    public function updateAction($id) {
        $query = TaskActivity::get($id);
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
        $data = TaskActivity::get($id)->data;
        if ($data) {
            $data->delete();
        }
        return array(
            'success' => TRUE
        );
    }
}