<?php
namespace App\Skp\Controllers;

use App\Skp\Models\SkpItem;

class SkpItemsController extends \Micro\Controller {

    public function findAction() {

        return SkpItem::get()
            ->join('App\Skp\Models\Skp', 'ski_skp_id = skp_id', '', 'LEFT')
            ->filterable()
            ->sortable()
            ->paginate();

    }

}