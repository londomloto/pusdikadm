<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Skp;
use App\Skp\Models\Task;
use App\Users\Models\User;
use Micro\Helpers\Date;

class SkpController extends \Micro\Controller {

    public function findAction() {
        $query = Task::get()
            ->alias('task')
            ->columns(array(
                'task.skp_id'
            ))
            ->join('App\Users\Models\User', 'user.su_id = task.skp_su_id', 'user')
            ->filterable()
            ->sortable()
            ->groupBy('task.skp_id');

        if ( ! $this->role->can('manage@skp')) {
            $auth = $this->auth->user();
            $query
                ->join('App\Skp\Models\TaskUser', 'task_user.sku_skp_id = task.skp_id', 'task_user', 'LEFT')
                ->andWhere('task_user.sku_su_id = :user:', array('user' => $auth['su_id']));

        }

        $params = $this->request->getQuery('params');

        if ( ! empty($params)) {
            $params = json_decode($params, TRUE);
            if (isset($params['status']) && ! empty($params['status'])) {
                $query->join('App\Skp\Models\TaskStatus', 'task_status.sks_skp_id = task.skp_id AND task_status.sks_deleted = 0', 'task_status', 'LEFT');
                $query->join('App\Kanban\Models\KanbanStatus', 'kst.kst_status = task_status.sks_status', 'kst', 'LEFT');
                $query->join('App\Kanban\Models\KanbanPanel', 'kp.kp_id = kst.kst_kp_id', 'kp', 'LEFT');
                $query->inWhere('kp.kp_id', $params['status'][1]);
            }
        }

        $result = $query->paginate();

        $result->data = $result->data->filter(function($row){
            $task = Task::findFirst($row->skp_id);
            $data = $task->toArray();
            $data['skp_link'] = $task->getLink();
            $data['statuses'] = $task->getCurrentStatuses()->filter(function($status){
                return $status->toArray();
            });
            return $data;
        });

        return $result;
    }

    public function findByIdAction($id) {
        $result = Task::get($id);

        if ($this->request->getQuery('display') == 'report') {
            $task = $result->data;
            $data = $task->toArray();
            $data['skp_period_end'] = Date::format($data['skp_end_date'], 'F Y');
            $data['skp_objection_dt_formatted'] = Date::format($data['skp_objection_dt'], 'd F Y');
            $data['skp_response_dt_formatted'] = Date::format($data['skp_response_dt'], 'd F Y');
            $data['skp_resolution_dt_formatted'] = Date::format($data['skp_resolution_dt'], 'd F Y');
            $data['skp_report_dt_formatted'] = Date::format($data['skp_report_dt'], 'd F Y');
            $data['skp_receive_dt_formatted'] = Date::format($data['skp_receive_dt'], 'd F Y');
            $data['skp_disposition_dt_formatted'] = Date::format($data['skp_disposition_dt'], 'd F Y');

            $data['items'] = $task->getItems("ski_extra = 0")->filter(function($row){
                return $row->toArray();
            });

            $data['extra'] = $task->getItems("ski_extra = 1")->filter(function($row){
                return $row->toArray();
            });

            $data['behaviors'] = $task->getBehaviors()->filter(function($row){
                return $row->toArray();
            });

            $result->data = $data;
        }

        return $result;
    }
    
    public function createAction() {

    }

    // only for update total & performance & behaviors
    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = Skp::get($id);

        if ($query->data) {
            $query->data->save($post);
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

    public function saveBehaviorsAction($id) {
        $skp = Task::get($id)->data;

        if ($skp) {
            $post = $this->request->getJson();
            $skp->saveBehaviors($post['behaviors']);

            $changed = NULL;

            foreach($post['behaviors'] as $item) {
                if ($item['tsb_dirty']) {
                    $changed = $item;
                    break;
                }
            }

            if ($changed) {
                $this->socket->broadcast('notify', array(
                    'type' => 'update_skp_behavior',
                    'task' => $skp->skp_id,
                    'project' => $skp->skp_task_project,
                    'scope' => $skp->getScope(),
                    'data' => json_encode(array(
                        'tsb_id' => $changed['tsb_id']
                    ))
                ));
            }

            

            return array(
                'success' => TRUE
            );
        }

        return array(
            'success' => FALSE
        );
    }

    public function observableUsersAction() {
        $auth = $this->auth->user();

        if ($this->role->can('manage@skp')) {
            return User::get()->filterable()->sortable()->paginate();
        } else {
            $query = Task::get()
                ->alias('task')
                ->columns(array(
                    'user.su_id',
                    'MAX(COALESCE(user.su_fullname, user.su_email)) AS su_fullname'
                ))
                ->join('App\Skp\Models\TaskUser', 'task.skp_id = task_user.sku_skp_id', 'task_user', 'LEFT')
                ->join('App\Users\Models\User', 'user.su_id = task.skp_su_id', 'user', 'LEFT')
                ->filterable()
                ->andWhere('task_user.sku_su_id = :assignee:', array('assignee' => $auth['su_id']))
                ->groupBy('user.su_id')
                ->orderBy('su_fullname');

            $result = $query->paginate()->filter(function($row){
                $user = User::findFirst($row->su_id);
                $data = array(
                    'su_id' => $user->su_id,
                    'su_fullname' => $user->getName(),
                    'su_email' => $user->su_email,
                    'su_no' => $user->su_no,
                    'su_sg_name' => $user->getGradeName(),
                    'su_avatar_thumb' => $user->getAvatarThumb()
                );
                return $data;
            });
            return $result;
        }
    }

    public function groupedStatusesAction() {
        return \App\Kanban\Models\KanbanPanel::get()
            ->join('App\Kanban\Models\KanbanSetting', 'ks_id = kp_ks_id', NULL, 'LEFT')
            ->filterable()
            ->andWhere("ks_module = 'skp'")
            ->sortable()
            ->paginate();
    }
}