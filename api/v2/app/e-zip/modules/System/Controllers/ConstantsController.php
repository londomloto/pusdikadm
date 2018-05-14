<?php
namespace App\System\Controllers;

use App\System\Models\Constant;

class ConstantsController extends \Micro\Controller {

    public function findAction() {
        return Constant::get()->paginate();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = Constant::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }
}