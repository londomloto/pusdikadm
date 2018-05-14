<?php
namespace App\Departments\Controllers;

use App\Departments\Models\Department;

class DepartmentsController extends \Micro\Controller {

    public function findAction() {
        return Department::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        
        if (empty($post['sdp_acronym'])) {
            $post['sdp_acronym'] = $post['sdp_name'];
        }

        $data = new Department();

        if ($data->save($post)) {
            return Department::get($data->sdp_id);
        }

        return Department::none();
    }

    public function updateAction($id) {
        $query = Department::get($id);
        $post = $this->request->getJson();

        if (empty($post['sdp_acronym'])) {
            $post['sdp_acronym'] = $post['sdp_name'];
        }

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Department::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }
}