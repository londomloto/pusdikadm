<?php
namespace App\Tasks\Controllers;

use App\Tasks\Models\TaskActivity;

class TasksActivitiesController extends \Micro\Controller {

    public function findAction() {
        return TaskActivity::get()
            ->filterable()
            ->sortable()
            ->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $type = isset($post['tta_type']) ? $post['tta_type'] : 'comment';

        return TaskActivity::log($type, $post);
    }

    public function updateAction($id) {
        $query = TaskActivity::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function uploadAction() {
        $result = array(
            'success' => FALSE,
            'data' => NULL
        );

        if ($this->request->hasFiles()) {
            $request = $this->request->getFiles();
            $file = $request[0];
            $type = $file->getExtension();
            $name = md5('attachment_'.date('ymdhis')).'.'.$type;
            $path = APPPATH.'public/resources/attachments/'.$name;

            if (@$file->moveTo($path)) {
                $code = '';
                if ($this->file->isImage($path)) {
                    /*$code = sprintf(
                        '<p>![%s](%s "%s")</p>',
                        $this->url->getBaseUrl().'public/resources/attachments/'.$name,
                        $this->url->getSiteUrl('/assets/thumb').'?s=public/resources/attachments/'.$name.'&w=100&h=100',
                        $name,
                        $name
                    );*/
                    $code .= sprintf(
                        '<p>[image:%s]</p>',
                        $name
                    );
                } else {
                    /*$code .= sprintf(
                        '<p><iron-icon icon="attachment"></iron-icon>&nbsp;[%s](%s)</p>',
                        $name,
                        $this->url->getBaseUrl().'public/resources/attachments/'.$name
                    );*/
                    $code .= sprintf(
                        '<p>[attachment:%s]</p>',
                        $name
                    );
                }

                $result['success'] = TRUE;
                $result['data'] = array(
                    'code' => $code
                );
            }
        }

        return $result;
    }
    
    public function deleteAction($id) {
        $data = TaskActivity::get($id)->data;
        if ($data) {
            $data->delete();
        }
        return array(
            'success' => TRUE
        );
    }
}