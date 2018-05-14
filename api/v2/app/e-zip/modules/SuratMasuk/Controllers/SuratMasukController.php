<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\Task;
use App\SuratMasuk\Models\TaskUser;
use App\SuratMasuk\Models\Disposition;
use App\SuratMasuk\Models\SuratMasukFile;
use App\Users\Models\User;
use Micro\Helpers\Date;
use App\Activities\Models\Activity;

class SuratMasukController extends \Micro\Controller {

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

    public function deleteAction($id) {
        $data = Skp::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array('success' => $done);
    }

    public function groupedStatusesAction() {
        return \App\Kanban\Models\KanbanPanel::get()
            ->join('App\Kanban\Models\KanbanSetting', 'ks_id = kp_ks_id', NULL, 'LEFT')
            ->filterable()
            ->andWhere("ks_module = 'surat-masuk'")
            ->sortable()
            ->paginate();
    }

    public function notifyAction($id) {
        $task = Task::get($id)->data;
        $post = $this->request->getJson();

        if ($task) {

            $log = Activity::log($post['type'], array(
                'ta_task_ns' => $task->getScope(),
                'ta_task_id' => $task->tsm_id,
                'ta_sp_id' => $task->tsm_task_project,
                'ta_data' => json_encode($post['data'])
            ));

            if ($log) {
                $log->subscribe($post['users']);
                $log->broadcast();
            }
        }

        return array(
            'success' => TRUE
        );
    }

    public function uploadAction() {
        $success = $this->uploader->initialize(array(
            'path' => PUBPATH.'resources/attachments/',
            'encrypt' => TRUE
        ))->upload();

        $data = array();

        if ($success) {
            $result = $this->uploader->getResult();
            $data['tsmf_file'] = $result->filename;
            $data['tsmf_file_url'] = $this->url->getBaseUrl().'public/resources/attachments/'.$result->filename;
            $data['tsmf_type'] = $result->filetype;
            $data['tsmf_type_formatted'] = SuratMasukFile::formatType($result->filetype);
            $data['tsmf_orig'] = $result->origname;
            $data['tsmf_size'] = $result->filesize;
            $data['tsmf_size_formatted'] = SuratMasukFile::formatSize($result->filesize);
        }

        return array(
            'success' => $success,
            'data' => $data
        );
    }

    public function outstandingsAction($id) {
        $task = Task::get($id)->data;
        $data = array();

        if ($task) {
            
            $auth = $this->auth->user();

            foreach($task->getDistributions() as $dist) {
                $sending = $dist['sending'];
                $receiving = $dist['receiving'];

                if ($receiving->tdp_responsible == $auth['su_id']) {
                    $outstanding = (($receiving->tdp_flag != 'RECEIVED') || empty($receiving->tdp_receiving_date));
                    if ($outstanding) {
                        $data[] = array(
                            'sending' => $sending->toArray(),
                            'receiving' => $receiving->toArray()
                        );    
                    }
                }
            }
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    public function sendAction($id) {
        $task = Task::get($id)->data;

        if ($task) {

            $assignee = array();
            $distributions = $task->getDistributions();

            foreach($task->getTaskUsers() as $item) {
                if ($item->tsmu_persistent == 1 && ($user = $item->user)) {
                    $assignee[$user->su_id] = array(
                        'su_id' => $user->su_id,
                        'su_fullname' => $user->getName(),
                        'su_persistent' => 1
                    );
                }
            }

            $drafts = array();

            foreach($distributions as $dist) {
                $sending = $dist['sending'];
                $receiving = $dist['receiving'];

                if (($responsible = $receiving->responsible) && !isset($assignee[$responsible->su_id])) {
                    $assignee[$responsible->su_id] = array(
                        'su_id' => $responsible->su_id,
                        'su_fullname' => $responsible->getName(),
                        'su_persistent' => 0
                    );
                }

                if ($sending->tdp_flag == 'DRAFT') {
                    $sending->tdp_flag = 'SENT';
                    $sending->save();
                }

                if ($receiving->tdp_flag == 'DRAFT') {
                    $drafts[] = $dist;
                }
            }

            $assignee = array_values($assignee);

            if (count($assignee) > 0) {
                $task->saveUsers($assignee, FALSE);
            }

            if (count($drafts) > 0) {

                $subs = array();

                foreach($drafts as $d) {
                    $d['receiving']->tdp_flag = 'SENT';
                    $d['receiving']->save();

                    if ( ! empty($d['receiving']->tdp_responsible)) {
                        if ($d['receiving']->tdp_type == 'DISTRIBUTION') {
                            $subs[] = $d['receiving']->tdp_responsible;
                        } else {
                            // one by one
                            $log = Activity::log('disposition', array(
                                'ta_task_ns' => $task->getScope(),
                                'ta_task_id' => $task->tsm_id,
                                'ta_sp_id' => $task->tsm_task_project,
                                'ta_data' => json_encode(array(
                                    'disposition' => $d['sending']->tdp_name,
                                    'from' => $d['sending']->getResponsibleLabel(),
                                    'subject' => $task->tsm_subject
                                ))
                            ));

                            if ($log) {
                                $log->subscribe(array($d['receiving']->tdp_responsible));
                                $log->broadcast();
                            }
                        }
                    }
                }

                if (count($subs) > 0) {
                    $log = Activity::log('distribution', array(
                        'ta_task_ns' => $task->getScope(),
                        'ta_task_id' => $task->tsm_id,
                        'ta_sp_id' => $task->tsm_task_project,
                        'ta_data' => json_encode(array(
                            'from' => $task->tsm_from,
                            'subject' => $task->tsm_subject
                        ))
                    ));

                    if ($log) {
                        $log->subscribe($subs);
                        $log->broadcast();
                    }
                }
            }
        }

        return array(
            'success' => TRUE
        );
    }

    public function receiveAction($id) {
        $post = $this->request->getJson();
        $task = Task::get($id)->data;
        
        $dist = Disposition::get($post['receiving'])->data;

        if ($task && $dist) {
            $dist->receive();
        }
        
        return array(
            'success' => TRUE
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

    public function dispositionsAction($id) {
        $task = Task::get($id)->data;
        $tree = array();

        if ($task) {

        }

        return array(
            'success' => TRUE,
            'data' => $tree
        );
    }
}