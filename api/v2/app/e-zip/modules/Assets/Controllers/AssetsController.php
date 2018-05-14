<?php
namespace App\Assets\Controllers;

class AssetsController extends \Micro\Controller {
    /**
     * GET
     */
    public function thumbAction() {
        $q = $this->request->getQuery();

        $s = $q['s'];
        $w = $q['w'];
        $h = $q['h'];

        if (empty($h)) {
            $h = 100;
        }

        if (empty($w)) {
            $w = 100;
        }
        
        $image = new \Micro\Image(APPPATH.$s);
        $image->thumb($w, $h);
    }

    /**
     * GET
     */
    public function downloadAction() {
        $source = $this->request->getQuery('s');

        $file = APPPATH.$source;
        
        if (file_exists($file) && is_file($file)) {
            $this->file->download($file);    
        } else {
            $this->response->setStatusCode('404', 'Not Found');
            $this->response->send();
        }
    }
}