<?php
namespace App\SuratMasuk\Models;

class TaskLabel extends \Micro\Model {

    public function getSource() {
        return 'trx_masuk_labels';
    }

}