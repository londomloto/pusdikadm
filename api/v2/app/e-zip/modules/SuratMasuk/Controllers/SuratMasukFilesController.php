<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\SuratMasukFile;

class SuratMasukFilesController extends \Micro\Controller {

    public function findAction() {
        return SuratMasukFile::get()->filterable()->sortable()->paginate();
    }

}