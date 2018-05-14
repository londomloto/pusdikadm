<?php
namespace App\Skp\Controllers;

use App\Users\Models\User;
use App\Skp\Models\Task;
use App\Activities\Models\Activity;
use Micro\Helpers\Date;

class LiveController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getParams();

        $startYear = $this->request->getQuery('start_year');
        $endYear = $this->request->getQuery('end_year');

        if (empty($startYear)) {
            $startYear = date('Y');
        }

        if (empty($endYear)) {
            $endYear = $startYear;
        }

        $query = User::get()
            ->columns(array(
                'user.su_id AS skp_su_id',
                'MAX(user.su_fullname) AS skp_su_fullname', 
                'MAX(skp.skp_id) AS skp_id',
                'MAX(YEAR(skp.skp_start_date)) as skp_year',
                'COUNT(ski.ski_id) AS skp_items'
            ))
            ->alias('user') 
            ->join('App\Skp\Models\Skp', "user.su_id = skp.skp_su_id AND YEAR(skp.skp_start_date) >= '$startYear' AND YEAR(skp.skp_end_date) <= '$endYear'", 'skp', 'LEFT')
            ->join('App\Skp\Models\SkpItem', 'skp.skp_id = ski.ski_skp_id', 'ski', 'LEFT')
            ->andWhere('user.su_active = 1 AND user.su_incognito = 0')
            ->groupBy('user.su_id')
            ->orderBy('skp_su_fullname');

        $result = $query->paginate();

        //print_r($query->getBuilder()->getQuery()->getSql());

        $result->filter(function($row) use ($startYear) {
            $user = User::findFirst($row->skp_su_id);
            $hide = $row->skp_items > 0;
            $link = NULL;

            $year = ! empty($row->skp_year) ? $row->skp_year : $startYear;

            if ( ! empty($row->skp_id)) {
                $task = Task::findFirst($row->skp_id);
                if ($task) {
                    $link = $task->getLink();
                }
            }

            $item = array(
                'skp_id' => $row->skp_id,
                'skp_su_id' => $row->skp_su_id,
                'skp_su_no' => $user->su_no,
                'skp_su_fullname' => $user->getName(), 
                'skp_su_sg_name' => $user->getGradeName(),
                'skp_su_avatar_thumb' => $user->getAvatarThumb(),
                'skp_year' => $year,
                'skp_anim' => FALSE,
                'skp_hide' => $hide,
                'skp_link' => $link
            );

            return $item;
        });

        return $result;
    }

    public function alertAction() {
        $post = $this->request->getJson();
        $data = $post['data'];

        if ( ! empty($data['skp_year'])) {
            $year = date('Y');
        } else {
            $year = $data['skp_year'];
        }

        $message = 'Outstanding dokumen SKP '.$year;

        if ( ! empty($data['skp_id'])) {
            
            $skp = Task::findFirst($data['skp_id']);

            if ($skp) {

                if ( ! empty($post['message'])) {
                    $message .= '<br>**'.$post['message'].'**';
                }

                $message = '<p>'.$message.'</p>';

                $payload = array(
                    'ta_task_ns' => $skp->getScope(),
                    'ta_task_id' => $skp->skp_id,
                    'ta_sp_id' => $skp->skp_task_project,
                    'ta_data' => json_encode(array(
                        'comment' => $message
                    ))
                );

                $log = Activity::log('warning', $payload);

                if ($log) {
                    $log->subscribe(array($data['skp_su_id']));
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
                $log->subscribe(array($data['skp_su_id']));
                $log->broadcast();
            }
        }

        return array(
            'success' => TRUE,
            'data' => $payload
        );

    }
}