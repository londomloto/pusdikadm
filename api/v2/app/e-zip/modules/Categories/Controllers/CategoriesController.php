<?php
namespace App\Categories\Controllers;

use App\Categories\Models\Category;

class CategoriesController extends \Micro\Controller {

    public function findAction() {
        return Category::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Category();

        if ($data->save($post)) {
            return Category::get($data->sct_id);
        }

        return Category::none();
    }

    public function updateAction($id) {
        $query = Category::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Category::get($id);

        if ($query->data) {
            $query->data->delete();
        }

        return array('success' => TRUE);
    }
}