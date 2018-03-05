<?php
namespace App\Presence\Controllers;

use App\Presence\Models\Task;

class PresenceController extends \Micro\Controller {

    public function findAction() {
        return Task::get()->filterable()->sortable()->paginate();
    }

    public function findByIdAction($id) {
        return Presence::get($id);
    }

    public function createAction() {
        $post = $this->request->getJson();

        // validate first
        $data = Presence::findFirst(array(
            'tpr_su_id = :user: AND tpr_date = :date:',
            'bind' => array(
                'user' => $post['tpr_su_id'],
                'date' => $post['tpr_date']
            )
        ));

        if ($data) {
            return array(
                'success' => FALSE,
                'message' => 'Dokumen absensi tanggal '.date('d M Y', strtotime($post['tpr_date'])).' sudah pernah dibuat'
            );
        }

        $data = new Presence();

        if ($data->save($post)) {
            return Presence::get($data->tpr_id);
        }

        return Presence::none();
    }

    public function updateAction($id) {
        $query = Presence::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $data = Presence::get($id)->data;

        if ($data) {
            return array(
                'success' => $data->delete()
            );
        }

        return array('success' => FALSE);
    }

    public function attachAction() {
        $success = $this->uploader->initialize(array(
            'path' => APPPATH.'public/resources/attachments/',
            'encrypt' => TRUE
        ))->upload();

        $data = $this->uploader->getResult();

        if ( ! is_null($data)) {
            unset($data->filepath);
        }

        return array(
            'success' => $success,
            'data' => $data
        );
    }

    public function uploadAction($id) {
        $data = Presence::get($id)->data;

        if ($data) {
            if ($this->request->hasFiles()) {
                foreach($this->request->getFiles() as $file) {
                    $type = $file->getExtension();
                    $name = 'bukti_absensi_'.$data->tpr_id.'.'.$type;
                    $path = APPPATH.'public/resources/attachments/'.$name;

                    if (@$file->moveTo($path)) {
                        $data->tpr_file = $name;
                        $data->save();
                    }
                }
            }
        }

        return array(
            'success' => TRUE,
            'data' => $data ? $data->toArray() : NULL
        );
    }

    public function downloadAction($id) {
        $data = Presence::get($id)->data;

        if ($data && ! empty($data->tpr_file)) {
            $path = APPPATH.'public/resources/attachments/'.$data->tpr_file;
            
            if (file_exists($path) && is_file($path)) {
                $this->file->download($path);
            }
        }
    }

}