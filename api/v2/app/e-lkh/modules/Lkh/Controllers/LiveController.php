<?php
namespace App\Lkh\Controllers;

use App\Users\Models\User;
use App\Lkh\Models\Task;
use App\Activities\Models\Activity;
use Micro\Helpers\Date;

class LiveController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getParams();

        $startDate = $this->request->getQuery('start_date');
        $endDate = $this->request->getQuery('end_date');

        if (empty($startDate)) {
            $startDate = date('Y-m-d');
        }

        if (empty($endDate)) {
            $endDate = $startDate;
        }

        $query = User::get()
            ->columns(array(
                'user.su_id AS lkd_su_id',
                'MAX(user.su_fullname) AS lkd_su_fullname', 
                'MAX(lkh.lkh_id) AS lkd_lkh_id',
                'MAX(lkd.lkd_id) AS lkd_id',
                'MAX(lkd.lkd_date) AS lkd_date',
                'COUNT(lki.lki_id) AS lkd_items'
            ))
            ->alias('user') 
            ->join('App\Lkh\Models\Lkh', "user.su_id = lkh.lkh_su_id", 'lkh', 'LEFT')
            ->join('App\Lkh\Models\LkhDay', "lkh.lkh_id = lkd.lkd_lkh_id AND lkd.lkd_date BETWEEN '$startDate' AND '$endDate'", 'lkd', 'LEFT') 
            ->join('App\Lkh\Models\LkhItem', 'lkd.lkd_id = lki.lki_lkd_id', 'lki', 'LEFT')
            ->andWhere('user.su_active = 1 AND user.su_incognito = 0')
            ->groupBy('user.su_id')
            ->orderBy('lkd_su_fullname');

        $result = $query->paginate();

        //print_r($query->getBuilder()->getQuery()->getSql());

        $result->filter(function($row) use ($startDate) {
            $user = User::findFirst($row->lkd_su_id);
            $hide = $row->lkd_items > 0;
            $link = NULL;

            $date = ! empty($row->lkd_date) ? $row->lkd_date : $startDate;

            if ( ! empty($row->lkd_lkh_id)) {
                $task = Task::findFirst($row->lkd_lkh_id);
                if ($task) {
                    $link = $task->getLink();
                }
            }

            $item = array(
                'lkd_id' => $row->lkd_id,
                'lkd_lkh_id' => $row->lkd_lkh_id,
                'lkd_su_id' => $row->lkd_su_id,
                'lkd_su_no' => $user->su_no,
                'lkd_su_fullname' => $user->getName(), 
                'lkd_su_grade' => $user->su_grade,
                'lkd_su_avatar_thumb' => $user->getAvatarThumb(),
                'lkd_date' => $date,
                'lkd_anim' => FALSE,
                'lkd_hide' => $hide,
                'lkd_link' => $link
            );

            return $item;
        });

        return $result;
    }

    public function alertAction() {
        $post = $this->request->getJson();
        $data = $post['data'];

        if ( ! empty($data['lkd_date'])) {
            $date = Date::create($data['lkd_date'])->format('d M Y');    
        } else {
            $date = isset($post['start_date']) ? $post['start_date'] : date('Y-m-d');
            $date = Date::create($date)->format('d M Y');
        }
        
        $message = 'Outstanding kegiatan harian tanggal '.$date;

        if ( ! empty($data['lkd_lkh_id'])) {
            $lkh = Task::findFirst($data['lkd_lkh_id']);
            if ($lkh) {

                if ( ! empty($post['message'])) {
                    $message .= '<br>**'.$post['message'].'**';
                }

                $message = '<p>'.$message.'</p>';

                $payload = array(
                    'ta_task_ns' => $lkh->getScope(),
                    'ta_task_id' => $lkh->lkh_id,
                    'ta_sp_id' => $lkh->lkh_task_project,
                    'ta_data' => json_encode(array(
                        'comment' => $message
                    ))
                );

                $log = Activity::log('warning', $payload);

                if ($log) {
                    $log->subscribe(array($data['lkd_su_id']));
                    $log->broadcast();
                }

            }
        } else {

            if ( ! empty($post['message'])) {
                $message .= ' - '.$post['message'];
            }

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
                $log->subscribe(array($data['lkd_su_id']));
                $log->broadcast();
            }
        }

        return array(
            'success' => TRUE,
            'data' => $payload
        );

    }
}