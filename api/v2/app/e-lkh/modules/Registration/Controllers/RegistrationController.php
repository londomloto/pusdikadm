<?php
namespace App\Registration\Controllers;

use App\Registration\Models\Task;

class RegistrationController extends \Micro\Controller {

    public function findAction() {

        $query = Task::get()
            ->alias('task')
            ->columns(array(
                'task.su_id',
            ))
            ->join('App\Registration\Models\TaskStatus', 'task_status.tus_su_id = task.su_id AND task_status.tus_deleted = 0', 'task_status', 'LEFT')
            ->groupBy('task.su_id')
            ->filterable()
            ->andWhere('task_status.tus_id IS NOT NULL')
            ->sortable();

        $payload = $this->request->getParams();

        if ( ! isset($payload['sort'])) {
            $query->orderBy('task.su_fullname ASC');
        }

        if (isset($payload['params'])) {
            $params = json_decode($payload['params'], TRUE);
            if (isset($params['status']) && ! empty($params['status'])) {
                $query
                    ->join('App\Kanban\Models\KanbanStatus', 'kanban_status.kst_status = task_status.tus_status', 'kanban_status', 'LEFT')
                    ->join('App\Kanban\Models\KanbanPanel', 'kanban_status.kst_kp_id = kanban_panel.kp_id', 'kanban_panel', 'LEFT')
                    ->inWhere('kanban_panel.kp_id', $params['status'][1]);
            }
        }

        $result = $query->paginate();

        $result->data = $result->data->filter(function($row){
            $user = Task::findFirst($row->su_id);
            $item = $user->toArray();
            $item['statuses'] = $user->getCurrentStatuses()->filter(function($status){
                return $status->toArray();
            });

            return $item;
        });

        return $result;

    }

    public function groupedStatusesAction() {
        return \App\Kanban\Models\KanbanPanel::get()
            ->join('App\Kanban\Models\KanbanSetting', 'ks_id = kp_ks_id', NULL, 'LEFT')
            ->filterable()
            ->andWhere("ks_module = 'pendaftaran'")
            ->sortable()
            ->paginate();
    }

}