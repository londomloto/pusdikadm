<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\LkhExam;
use App\Activities\Models\Activity;

class LkhExamsController extends \Micro\Controller {

    public function findAction() {
        return LkhExam::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $exam = new LkhExam();

        if ($exam->save($post)) {
            $task = $exam->getTask();
            if ($task && $exam->hasNotes()) {
                $log = Activity::log('examine', array(
                    'ta_task_ns' => $task->getScope(),
                    'ta_task_id' => $task->lkh_id,
                    'ta_sp_id' => $task->lkh_task_project,
                    'ta_data' => json_encode(array(
                        'comment' => '<p>**'.$exam->getLabel().'** ('.$exam->lke_notes.')'
                    ))
                ));

                if ($log) {
                    $log->subscribe();
                    $log->broadcast();
                }
            }
            
            return LkhExam::get($exam->lke_id);
        }

        return LkhExam::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = LkhExam::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $exam = LkhExam::get($id)->data;

        if ($exam) {
            $exam->delete();
        }

        return array(
            'success' => TRUE
        );
    }
}