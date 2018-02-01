<?php
namespace App\Skp\Controllers;

use App\Projects\Models\Project,
    App\Tasks\Models\Task,
    App\Tasks\Models\TaskStatus,
    App\Skp\Models\Exam;

class ExamController extends \Micro\Controller {

    public function modulesAction() {

        return Project::get()
            ->alias('a')
            ->join('App\Kanban\Models\KanbanSetting', 'a.sp_worksheet_id = b.ks_id', 'b')
            ->andWhere('b.ks_purpose = 2')
            ->filterable()
            ->orderBy('a.sp_title') 
            ->paginate();

    }

    public function initAction() {
        $post = $this->request->getJson();
        $auth = $this->auth->user();
        
        $project = Project::get($post['skp_exam_id'])->data;

        if ($project && $project->worksheet) {
            
            $workspaces = $project->worksheet->getWorkspaces();

            if (count($workspaces) > 0) {

                $workspace = $workspaces[0];

                $task = new Task();
                $task->tt_sp_id = $project->sp_id;
                $task->tt_title = $post['skp_su_fullname'].' - '.date('d M Y', strtotime($post['skp_date']));
                $task->tt_created_dt = date('Y-m-d H:i:s');
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

                        $create = array(
                            'tts_tt_id' => $task->tt_id,
                            'tts_status' => $init['data']['id'],
                            'tts_target' => $init['data']['target'],
                            'tts_worker' => $worker->name(),
                            'tts_deleted' => 0,
                            'tts_created' => date('Y-m-d H:i:s'),
                            'tts_query' => json_encode($post),
                            'tts_data_id' => $post['skp_id'],
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
}