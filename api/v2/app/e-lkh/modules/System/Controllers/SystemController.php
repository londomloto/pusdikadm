<?php
namespace App\System\Controllers;

class SystemController extends \Micro\Controller {

    public function backupAction() {

        $post = $this->request->getJson();
        $desc = $this->db->getDescriptor();
        $file = APPPATH.'dumps/'.str_replace(' ', '_', $post['name']);

        $comm = 
            'mysqldump '.
            '--opt '.
            '-h'.$desc['host'].' '.
            '-u'.$desc['username'].' '.
            '-p'.$desc['password'].' '.$desc['dbname'].' '.
            '> '.$file;

        exec($comm);

        if (file_exists($file)) {
            $this->file->download($file);
        }
    }

}