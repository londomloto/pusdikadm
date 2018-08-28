<?php
namespace App\SuratKeluar\Models;

class TaskLabel extends \Micro\Model {

    public function getSource() {
        return 'trx_keluar_labels';
    }

}