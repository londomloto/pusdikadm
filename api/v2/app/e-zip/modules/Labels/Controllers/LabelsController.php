<?php
namespace App\Labels\Controllers;

use App\Labels\Models\Label;

class LabelsController extends \Micro\Controller {

    public function findAction() {
        return Label::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();

        $found = Label::findFirst(array(
            'sl_label = :label:',
            'bind' => array(
                'label' => $post['sl_label']
            )
        ));

        if ($found) {
            return array(
                'success' => FALSE,
                'message' => 'Label name already exists'
            );
        }

        $user = $this->auth->user();

        $post['sl_created_dt'] = date('Y-m-d H:i:s');
        $post['sl_created_by'] = $user['su_id'];
        
        $data = new Label();

        if ($data->save($post)) {
            return Label::get($data->sl_id);
        }

        return Label::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();

        $found = Label::findFirst(array(
            'sl_label = :label: AND sl_id != :id:',
            'bind' => array(
                'label' => $post['sl_label'],
                'id' => $post['sl_id']
            )
        ));

        if ($found) {
            return array(
                'success' => FALSE,
                'message' => 'Label name already exists'
            );
        }

        $query = Label::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $label = Label::get($id)->data;
        if ($label) {
            $label->delete();
        }

        return array(
            'success' => TRUE
        );
    }
}