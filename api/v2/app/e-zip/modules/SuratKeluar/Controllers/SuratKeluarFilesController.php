<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\SuratKeluarFile;

class SuratKeluarFilesController extends \Micro\Controller {

    public function findAction() {
        return SuratKeluarFile::get()->filterable()->sortable()->paginate();
    }

}