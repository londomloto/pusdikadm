<?php
namespace App\SuratMasuk\Models;

class Document extends \Micro\Model {

    public function getSource() {
        return 'trx_surat_masuk_docs';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsmd_size_formatted'] = \Micro\App::getDefault()->file->formatSize($this->tsmd_size);
        $data['tsmd_file_url'] = $this->getFileUrl();
        return $data;
    }

    public function getFileUrl() {
        $app = \Micro\App::getDefault();
        return $app->url->getBaseUrl().'public/resources/documents/'.$this->tsmd_file;
    }
}