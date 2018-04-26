<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\Task;
use App\Activities\Models\Activity;
use App\Users\Models\User;
use App\Users\Models\UserToken;
use Micro\Helpers\Date;

class LkhController extends \Micro\Controller {

    public function findAction() {
        $query = Task::get()
            ->alias('task')
            ->columns(array(
                'task.lkh_id'
            ))
            ->join('App\Users\Models\User', 'user.su_id = task.lkh_su_id', 'user')
            ->filterable()
            ->sortable()
            ->groupBy('task.lkh_id');

        if ( ! $this->role->can('manage@lkh')) {
            $auth = $this->auth->user();
            $query
                ->join('App\Lkh\Models\TaskUser', 'task_user.lku_lkh_id = task.lkh_id', 'task_user', 'LEFT')
                ->andWhere('task_user.lku_su_id = :user:', array('user' => $auth['su_id']));

        }

        $params = $this->request->getQuery('params');

        if ( ! empty($params)) {
            $params = json_decode($params, TRUE);
            if (isset($params['status']) && ! empty($params['status'])) {
                $query->join('App\Lkh\Models\TaskStatus', 'task_status.lks_lkh_id = task.lkh_id AND task_status.lks_deleted = 0', 'task_status', 'LEFT');
                $query->join('App\Kanban\Models\KanbanStatus', 'kst.kst_status = task_status.lks_status', 'kst', 'LEFT');
                $query->join('App\Kanban\Models\KanbanPanel', 'kp.kp_id = kst.kst_kp_id', 'kp', 'LEFT');
                $query->inWhere('kp.kp_id', $params['status'][1]);
            }
        }

        $result = $query->paginate();

        $result->data = $result->data->filter(function($row){
            $task = Task::findFirst($row->lkh_id);
            $data = $task->toArray();
            $data['lkh_link'] = $task->getLink();
            $data['statuses'] = $task->getCurrentStatuses()->filter(function($status){
                return $status->toArray();
            });
            return $data;
        });

        return $result;
    }

    public function findByIdAction($id) {
        return Task::get($id);
    }
    
    public function createAction() {
        
    }

    public function updateAction($id) {
        
    }

    public function deleteAction($id) {
        
    }

    public function alertAction() {
        $date = $this->request->getQuery('date');

        if (empty($date)) {
            $date = new \Moment\Moment();
            $date = $date->endOf('month')->format('Y-m-d');
        }

        // find outstanding task
        $result = Task::find(array(
            'lkh_start_date <= :date: AND lkh_end_date >= :date:',
            'bind' => array(
                'date' => $date
            )
        ));

        if ($result->count() > 0) {
            foreach($result as $task) {
                if ($task->lkh_flag == 'TODO') {
                    
                    $message = sprintf(
                        'Anda belum mengirimkan dokumen lkh: "%s" untuk diperiksa',
                        $task->getTitle()
                    );

                    $users = array($task->lkh_su_id);

                    $payload = array(
                        'ta_task_ns' => $task->getScope(),
                        'ta_task_id' => $task->lkh_id,
                        'ta_sp_id' => $task->lkh_task_project,
                        'ta_data' => json_encode(array(
                            'message' => $message
                        ))
                    );

                    $log = Activity::log('alert', $payload);
                    
                    if ($log) {
                        $log->subscribe($users);
                        $log->broadcast();

                        self::__notify($users, array(
                            'title' => 'Peringatan Sistem',
                            'body' => $message
                        ));
                    }
                }
                
            }    
        } else {
            $date = (new \Moment\Moment($date))->format('M Y');
            $gcm = $this->gcm;

            self::__traverse(function($users) use ($date, $gcm) {

                if (count($users) > 0) {
                    $message = sprintf(
                        'Anda belum membuat dokumen lkh periode %s',
                        $date
                    );

                    $payload = array(
                        'ta_task_ns' => NULL,
                        'ta_task_id' => NULL,
                        'ta_sp_id' => NULL,
                        'ta_data' => json_encode(array(
                            'message' => $message
                        ))
                    );
                    
                    $log = Activity::log('alert', $payload);

                    if ($log) {
                        $log->subscribe($users);
                        $log->broadcast();

                        self::__notify($users, array(
                            'title' => 'Peringatan Sistem',
                            'body' => $message
                        ));
                    }
                }

            });
        }
    }

    private static function __notify($users, $payload) {
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
            $topic = 'outstanding-lkh';

            $reg = $gcm->subscribe($topic, $tokens, TRUE);

            if ($reg->success) {
                $gcm->broadcast($topic, $payload);
                $unreg = $gcm->unsubscribe($topic, $tokens);
            }
            
        }
    }

    private static function __traverse($handler, $start = 0) {
        $limit = 25;
        $query = User::get()
            ->columns('su_id');
            //->groupBy('su_id');

        $query->limit($limit, $start);

        $result = $query->paginate();

        if ($result->data->count() > 0) {
            $users = array();
            
            foreach($result->data as $user) {
                $users[] = $user->su_id;
            }
            
            $handler($users);

            $start = ($start + $limit);
            self::__traverse($handler, $start);
        }
    }

    

    public function observableUsersAction() {
        $auth = $this->auth->user();

        if ($this->role->can('manage@lkh')) {
            return User::get()->filterable()->sortable()->paginate();
        } else {
            $query = Task::get()
                ->alias('task')
                ->columns(array(
                    'user.su_id',
                    'MAX(COALESCE(user.su_fullname, user.su_email)) AS su_fullname'
                ))
                ->join('App\Lkh\Models\TaskUser', 'task.lkh_id = task_user.lku_lkh_id', 'task_user', 'LEFT')
                ->join('App\Users\Models\User', 'user.su_id = task.lkh_su_id', 'user', 'LEFT')
                ->filterable()
                ->andWhere('task_user.lku_su_id = :assignee:', array('assignee' => $auth['su_id']))
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
            ->andWhere("ks_module = 'lkh'")
            ->sortable()
            ->paginate();
    }
}