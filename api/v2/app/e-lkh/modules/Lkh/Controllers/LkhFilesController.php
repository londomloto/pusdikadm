<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\LkhFile;

class LkhFilesController extends \Micro\Controller {

    public function deleteAction($id) {
        $file = LkhFile::get($id)->data;
        if ($file) {
            if ( ! empty($file->lkf_file)) {
                @unlink(APPPATH.'public/resources/lkh/'.$file->lkf_file);
            }
            $file->delete();
        }

        return array(
            'success' => TRUE
        );
    }

}