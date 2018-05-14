<?php
namespace App\SuratMasuk\Models;

class SuratMasukFile extends \Micro\Model {

    public function getSource() {
        return 'trx_masuk_files';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsmf_size_formatted'] = $this->getFormattedSize();
        $data['tsmf_type_formatted'] = $this->getFormattedType();
        $data['tsmf_file_url'] = $this->getFileUrl();
        return $data;
    }

    public function getFileUrl() {
        if ( ! empty($this->tsmf_file)) {
            return \Micro\App::getDefault()->url->getBaseUrl().'public/resources/attachments/'.$this->tsmf_file;
        }
        return '';
    }

    public function getFormattedType() {
        return self::formatType($this->tsmf_type);
    }

    public function getFormattedSize() {
        return self::formatSize($this->tsmf_size);
    }

    public static function formatType($type) {
        $type = (string)$type;

        if (strpos($type, 'image') !== FALSE) {
            return 'Gambar';
        } else {
            return 'Dokumen';
        }
    }

    public static function formatSize($value, $decimal = 2) {
        $value = (double)$value;
        $units = array('B', 'KB', 'MB', 'GB', 'TB');

        $bytes = max($value, 0);
        $power = floor(($bytes ? log($bytes) : 0) / log(1024));
        $power = min($power, count($units) - 1);
        $bytes /= pow(1024, $power);

        return round($bytes, $decimal).' '.$units[$power];
    }
}