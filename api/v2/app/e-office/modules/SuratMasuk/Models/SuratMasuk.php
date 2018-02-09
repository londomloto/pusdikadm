<?php
namespace App\SuratMasuk\Models;

use App\Sequence\Models\Sequence;

class SuratMasuk extends \Micro\Model {

    public function getSource() {
        return 'trx_surat_masuk';
    }
}