<?php
namespace App\Items\Controllers;

use App\Items\Models\Item;

class ItemsController extends \Micro\Controller {

    public function findAction() {

        return Item::get()
            ->filterable()
            ->paginate();

    }

    public function createAction() {
        $post = $this->request->getJson();
        $item = new Item();

        if ($item->save($post)) {
            return Item::get($item->ti_id);
        }

        return Item::none();
    }
}