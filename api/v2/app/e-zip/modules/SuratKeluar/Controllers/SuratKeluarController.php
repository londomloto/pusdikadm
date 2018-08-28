<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\Task;
use App\SuratKeluar\Models\SuratKeluarFile;
use App\Activities\Models\Activity;
use App\Users\Models\UserToken;

class SuratKeluarController extends \Micro\Controller {

    public function findAction() {
        $display = $this->request->getQuery('display');
        
        switch($display) {
            case 'database':

                $query = Task::get()
                    ->alias('task')
                    ->columns(array(
                        'task.tsk_id',
                        'category.sct_weight AS sct_weight'
                    ))
                    ->join('App\Categories\Models\Category', 'category.sct_id = task.tsk_category', 'category', 'LEFT')
                    ->groupBy('task.tsk_id')
                    ->filterable()
                    ->sortable();

                $params = $this->request->getQuery('params');

                if ( ! empty($params)) {
                    $params = json_decode($params, TRUE);
                    if (isset($params['status']) && ! empty($params['status'])) {
                        $query->join('App\SuratKeluar\Models\TaskStatus', 'task_status.tsks_tsk_id = task.tsk_id AND task_status.tsks_deleted = 0', 'task_status', 'LEFT');
                        $query->join('App\Kanban\Models\KanbanStatus', 'kst.kst_status = task_status.tsks_status', 'kst', 'LEFT');
                        $query->join('App\Kanban\Models\KanbanPanel', 'kp.kp_id = kst.kst_kp_id', 'kp', 'LEFT');
                        $query->inWhere('kp.kp_id', $params['status'][1]);
                    }
                }

                $result = $query->paginate();

                $result->filter(function($row){
                    $task = Task::findFirst($row->tsk_id);
                    
                    $data = $task->toArray();
                    
                    $data['tsk_link'] = $task->getLink();
                    $data['statuses'] = $task->getCurrentStatuses()->filter(function($status){
                        return $status->toArray();
                    });

                    return $data;
                });

                return $result;
            default:
                return Task::get()->sortable()->filterable()->paginate();
        }
    }

    // only for update total & performance & behaviors
    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = Task::get($id);

        if ($query->data) {
            
            if (isset($post['users'])) {
                $query->data->saveUsers($post['users']);
            }
            
            if (isset($post['files'])) {
                $query->data->saveFiles($post['files']);
            }
        }

        return $query;
    }

    public function uploadAction() {
        $success = $this->uploader->initialize(array(
            'path' => PUBPATH.'resources/attachments/',
            'encrypt' => TRUE
        ))->upload();

        $data = array();

        if ($success) {
            $result = $this->uploader->getResult();
            $data['tskf_file'] = $result->filename;
            $data['tskf_file_url'] = $this->url->getBaseUrl().'public/resources/attachments/'.$result->filename;
            $data['tskf_type'] = $result->filetype;
            $data['tskf_type_formatted'] = SuratKeluarFile::formatType($result->filetype);
            $data['tskf_orig'] = $result->origname;
            $data['tskf_size'] = $result->filesize;
            $data['tskf_size_formatted'] = SuratKeluarFile::formatSize($result->filesize);
        }

        return array(
            'success' => $success,
            'data' => $data
        );
    }

    public function authorsAction($id) {
        $task = Task::get($id)->data;
        $data = array();

        if ($task) {
            $data = $task->getAuthors();
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    public function notifyAction($id) {
        $post = $this->request->getJson();

        $type = $post['type'];
        $subs = $post['subscribers'];

        $task = Task::get($id)->data;

        if ($task && count($subs) > 0) {

            switch($type) {
                case 'correction':

                    $log = Activity::log($type, array(
                        'ta_task_ns' => $task->getScope(),
                        'ta_task_id' => $task->tsk_id,
                        'ta_sp_id' => $task->tsk_task_project
                    ));

                    if ($log) {
                        $log->subscribe($subs);
                        $log->broadcast();

                        // notify gcm?
                        self::__deviceNotify($subs, array(
                            'title' => 'Koreksi Surat Keluar',
                            'body' => 'Anda menerima permohonan koreksi surat keluar '.$task->tsk_no,
                            'link' => $task->getLink(TRUE)
                        ));
                    }
            }

            return array(
                'success' => TRUE
            );    
        }

        return array(
            'success' => FALSE
        );
    }

    private static function __deviceNotify($users, $payload) {
        $result = UserToken::get()
            ->inWhere('sut_su_id', $users)
            ->execute();


        $tokens = array();

        foreach($result as $item) {
            if ( ! empty($item->sut_token)) {
                $tokens[] = $item->sut_token;
            }
        }

        if (count($tokens) > 0) {
            $gcm = \Micro\App::getDefault()->gcm;
            $topic = 'correction';

            $reg = $gcm->subscribe($topic, $tokens, TRUE);

            if ($reg->success) {
                $gcm->broadcast($topic, $payload);
                $unreg = $gcm->unsubscribe($topic, $tokens);
            }
        }
    }

    public function loadSignatureAction($id) {
        $task = Task::get($id)->data;
        if ($task && ! empty($task->tsk_signature)) {
            $sign = PUBPATH.'resources/signatures/'.$task->tsk_signature;
            if (file_exists($sign)) {
                $info = @getimagesize($sign);
                if ($info) {
                    $data = file_get_contents($sign);
                    $code = 'data:image/'.$info['mime'].';base64,'.base64_encode($data);

                    return array(
                        'success' => TRUE,
                        'data' => $code
                    );
                }
            }
        }

        return array(
            'success' => FALSE
        );
    }

    public function saveSignatureAction($id) {
        $task = Task::get($id)->data;
        if ($task && ! empty($task->tsk_signature)) {
            $sign = PUBPATH.'resources/signatures/'.$task->tsk_signature;
            if (file_exists($sign)) {
                $this->file->download($sign, 'signature.jpg');
            }
        }
    }

    public function signatureAction($id) {
        $data = Task::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $this->uploader->initialize(array(
                'path' => PUBPATH.'resources/signatures/',
                'encrypt' => TRUE
            ))->upload();

            if ($done) {
                $upload = $this->uploader->getResult();

                $data->tsk_signature = $upload->filename;
                $data->save();

                return array(
                    'success' => TRUE,
                    'data' => $data->toArray()
                );
            } else {
                // print_r($this->uploader->getMessage());
            }
        }

        return array(
            'success' => FALSE
        );
    }

    public function groupedStatusesAction() {
        return \App\Kanban\Models\KanbanPanel::get()
            ->join('App\Kanban\Models\KanbanSetting', 'ks_id = kp_ks_id', NULL, 'LEFT')
            ->filterable()
            ->andWhere("ks_module = 'surat-keluar'")
            ->sortable()
            ->paginate();
    }

    public function destinationsAction() {
        return Task::get()
            ->columns(array(
                'tsk_to AS label',
                'tsk_to AS value'
            ))
            ->groupBy('tsk_to')
            ->andWhere("tsk_to <> ''")
            ->filterable()
            ->paginate();
    }
}