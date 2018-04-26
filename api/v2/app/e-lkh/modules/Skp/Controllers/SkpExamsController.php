<?php
namespace App\Skp\Controllers;

use App\Skp\Models\SkpExam;
use App\Activities\Models\Activity;

class SkpExamsController extends \Micro\Controller {

    public function findAction() {
        return SkpExam::get()->filterable()->sortable()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $exam = new SkpExam();

        if ($exam->save($post)) {
            $task = $exam->getTask();

            if ($task && $exam->hasNotes()) {
                // log as comment
                $log = Activity::log('examine', array(
                    'ta_task_ns' => $task->getScope(),
                    'ta_task_id' => $task->skp_id,
                    'ta_sp_id' => $task->skp_task_project,
                    'ta_data' => json_encode(array(
                        'comment' => '<p>**'.$exam->getLabel().'** ('.$exam->ske_notes.')</p>'
                    ))
                ));

                if ($log) {
                    $log->subscribe();
                    $log->broadcast();
                }
            }

            return SkpExam::get($exam->ske_id);
        }

        return SkpExam::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = SkpExam::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $exam = SkpExam::get($id)->data;

        if ($exam) {
            $exam->delete();
        }

        return array(
            'success' => TRUE
        );
    }
}