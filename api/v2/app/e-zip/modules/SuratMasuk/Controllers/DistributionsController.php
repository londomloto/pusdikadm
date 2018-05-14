<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\Task;
use App\SuratMasuk\Models\Disposition;

class DistributionsController extends \Micro\Controller {

    public function findAction() {
        $task = Task::get($this->request->getQuery('task'))->data;
        $data = array();

        if ($task) {
            foreach($task->getDistributions() as $dist) {
                
                $data[] = array(
                    'sending' => $dist['sending']->toSimpleArray(),
                    'receiving' => $dist['receiving']->toSimpleArray()
                );
            }
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    public function createAction() {
        $post = $this->request->getJson();

        $post['sending']['tdp_type'] = 'DISTRIBUTION';
        $post['sending']['tdp_parent'] = 0;
        $post['sending']['tdp_name'] = 'Distribusi';

        $sending = new Disposition();

        if ($sending->save($post['sending'])) {
            $sending = $sending->refresh();
            $receiving = new Disposition();

            $post['receiving']['tdp_type'] = 'DISTRIBUTION';
            $post['receiving']['tdp_parent'] = $sending->tdp_id;

            $receiving->save($post['receiving']);

            return array(
                'success' => TRUE,
                'data' => array(
                    'sending' => $sending->toArray(),
                    'receiving' => $receiving->toArray()
                )
            );
        }

        return array(
            'success' => FALSE,
            'data' => NULL
        );
    }

    public function deleteAction($id) {
        $data = Disposition::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array(
            'success' => $done
        );
    }

    public function signatureAction($id) {
        $data = Disposition::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $this->uploader->initialize(array(
                'path' => PUBPATH.'resources/signatures/',
                'encrypt' => TRUE
            ))->upload();

            if ($done) {
                $upload = $this->uploader->getResult();

                $data->tdp_signature = $upload->filename;
                $data->save();
            } else {
                print_r($this->uploader->getMessage());
            }
        }

        return array(
            'success' => $done
        );
    }

}