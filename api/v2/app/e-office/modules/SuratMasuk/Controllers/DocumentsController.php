<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\Document;

class DocumentsController extends \Micro\Controller {

    public function findAction() {
        return Document::get()->filterable()->paginate();
    }

}