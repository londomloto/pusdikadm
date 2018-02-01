<?php
namespace App\Lkh\Controllers;

use App\Projects\Models\Project,
    App\Tasks\Models\Task,
    App\Tasks\Models\TaskStatus,
    App\Lkh\Models\Exam,
    App\Lkh\Models\Lkh;

class ExamController extends \Micro\Controller {

    public function modulesAction() {

        return Project::get()
            ->alias('a')
            ->join('App\Kanban\Models\KanbanSetting', 'a.sp_worksheet_id = b.ks_id', 'b')
            ->andWhere('b.ks_purpose = 1')
            ->filterable()
            ->orderBy('a.sp_title') 
            ->paginate();

    }

    public function initAction() {
        $post = $this->request->getJson();
        $auth = $this->auth->user();
        
        $project = Project::get($post['lkh_exam_id'])->data;

        if ($project && $project->worksheet) {
            
            $workspaces = $project->worksheet->getWorkspaces();

            if (count($workspaces) > 0) {

                $workspace = $workspaces[0];
                $today  = date('Y-m-d H:i:s');

                $task = new Task();
                $task->tt_sp_id = $project->sp_id;
                $task->tt_title = $post['lkh_su_fullname'].' - '.date('d M Y', strtotime($post['lkh_date']));
                $task->tt_created_dt = $today;
                $task->tt_creator_id = $auth['su_id'];
                $task->tt_updater_id = $task->tt_creator_id;
                $task->tt_updated_dt = $task->tt_created_dt;

                $task->tt_due_date = $project->sp_end_date;

                if (empty($task->tt_due_date)) {
                    $today = new \DateTime();
                    $today->modify('+1 day');
                    $task->tt_due_date = $today->format('Y-m-d');
                }

                if ($task->save()) {
                    $worker = $this->bpmn->worker($workspace['worker']);

                    $data = $task->toArray();
                    $init = $worker->start($data);

                    if ($init['data']) {
                        $status = new TaskStatus();

                        $query = array(
                            'date='.$post['lkh_date'],
                            'author='.$post['lkh_su_id']
                        );

                        foreach($post as $k => $v) {
                            if ( ! is_array($v)) {
                                $query[] = $k.'='.$v;    
                            }
                        }

                        $query  = '|'.implode('|', $query).'|';

                        $create = array(
                            'tts_tt_id' => $task->tt_id,
                            'tts_status' => $init['data']['id'],
                            'tts_target' => $init['data']['target'],
                            'tts_worker' => $worker->name(),
                            'tts_deleted' => 0,
                            'tts_created' => date('Y-m-d H:i:s'),
                            'tts_query' => $query,
                            'tts_data_id' => $post['lkh_id'],
                            'tts_content' => ''
                        );

                        if ($status->save($create)) {
                            return array(
                                'success' => TRUE
                            );
                        }
                    }
                }
            }
        }

        return array(
            'success' => FALSE
        );
    }

    public function flagAction($id) {
        $data = \App\Lkh\Models\Lkh::get(1)->data;

        $result = array(
            'success' => FALSE,
            'data' => NULL
        );

        if ($data) {
            $post = $data->toArray();
            $auth = $this->auth->user();
            $today = date('Y-m-d H:i:s');

            $flag = array();

            $date = $post['lkh_date'];
            $user = $post['lkh_su_id'];
            $time = strtotime($date);

            $m = date('m', $time);
            $y = date('Y', $time);

            $exam = Exam::findFirst(array(
                "lke_su_id = :user: AND YEAR(lke_date) = :y: AND lke_flag = 'Y'",
                'bind' => array(
                    'user' => $user,
                    'y' => $y
                )
            ));

            if ( ! $exam) {
                $exam = new Exam();
                
                $exam->lke_date = $date;
                $exam->lke_su_id = $user;
                $exam->lke_flag = 'Y';
                $exam->lke_created_dt = $today;
                $exam->lke_created_by = $auth['su_id'];

                $exam->save();

                $flag[] = 'Y';
            }

            $exam = Exam::findFirst(array(
                "lke_su_id = :user: AND MONTH(lke_date) = :m: AND YEAR(lke_date) = :y: AND lke_flag = 'M'",
                'bind' => array(
                    'user' => $user,
                    'y' => $y,
                    'm' => $m
                )
            ));

            if ( ! $exam) {
                $exam = new Exam();
                
                $exam->lke_date = $date;
                $exam->lke_su_id = $user;
                $exam->lke_flag = 'M';
                $exam->lke_created_dt = $today;
                $exam->lke_created_by = $auth['su_id'];

                $exam->save();

                $flag[] = 'M';
            }

            $exam = Exam::findFirst(array(
                "lke_su_id = :user: AND lke_date = :d: AND lke_flag = 'D'",
                'bind' => array(
                    'user' => $user,
                    'd' => $date
                )
            ));

            if ( ! $exam) {
                $exam = new Exam();
                
                $exam->lke_date = $date;
                $exam->lke_su_id = $user;
                $exam->lke_flag = 'D';
                $exam->lke_created_dt = $today;
                $exam->lke_created_by = $auth['su_id'];

                $exam->save();

                $flag[] = 'D';
            }

            $flag = implode('', $flag);
            $data->lkh_flag = $flag;
            $data->save();

            $result['success'] = TRUE;
            $result['data'] = $data->toArray();

        }

        return $result;
    }

    public function deleteAction($id) {
        
    }
}