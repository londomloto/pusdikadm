<?php
namespace App\Skp\Controllers;

use App\Skp\Models\SkpItem;

class SkpItemsController extends \Micro\Controller {

    public function findAction() {

        return SkpItem::get()
            ->filterable()
            ->sortable()
            ->paginate();

    }

    public function createAction() {
        $post = $this->request->getJson();
        $item = new SkpItem();

        if ($item->save($post)) {
            return SkpItem::get($item->ski_id);
        }

        return SkpItem::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = SkpItem::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $item = SkpItem::get($id)->data;
        if ($item) {
            $item->delete();
        }
        return array(
            'success' => TRUE
        );
    }

}