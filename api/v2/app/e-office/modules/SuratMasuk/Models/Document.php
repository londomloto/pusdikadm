<?php
namespace App\SuratMasuk\Models;

class Document extends \Micro\Model {

    public function getSource() {
        return 'trx_surat_masuk_docs';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsmd_download_url'] = $this->getDownloadUrl();
        return $data;
    }

    public function getDownloadUrl() {
        $app = \Micro\App::getDefault();
        return $app->url->getBaseUrl().'public/resources/documents/'.$this->tsmd_file;
    }
}