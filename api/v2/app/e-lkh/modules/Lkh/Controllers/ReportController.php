<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\Lkh;
use App\Lkh\Models\Task;
use App\Lkh\Models\TaskUser;
use App\Users\Models\User;
use Micro\Helpers\Date;
use Micro\Helpers\Theme;

class ReportController extends \Micro\Controller {
    
    public function sheetsAction() {

        $params = $this->request->getParams();
        $today = Date::today();

        $user = isset($params['user']) ? $params['user'] : NULL;
        $startDate = isset($params['start_date']) ? $params['start_date'] : NULL;
        $endDate = isset($params['end_date']) ? $params['end_date'] : NULL;

        if (empty($startDate)) {
            $startDate = $today->cloning()->startOf('year')->format('Y-m-d');
        }

        if (empty($endDate)) {
            $endDate = $today->cloning()->endOf('year')->format('Y-m-d');
        }

        if (empty($user)) {
            $auth = $this->auth->user();
            $user = $auth['su_id'];
        }

        $query = Lkh::get()
            ->columns(array(
                'lkh_id',
                'lkh_period',
                'COALESCE(user.su_fullname, user.su_email) AS lkh_su_fullname'
            ))
            ->join('App\Users\Models\User', 'lkh_su_id = user.su_id', 'user', 'LEFT')
            ->andWhere('lkh_start_date >= :start_date:', array('start_date' => $startDate))
            ->andWhere('lkh_end_date <= :end_date:', array('end_date' => $endDate))
            ->andWhere('lkh_su_id = :user:', array('user' => $user))
            ->orderBy('lkh_start_date ASC');

        $colors = Theme::colors(array('#ffeb3b'));
        $total = count($colors) - 1;
        $index = 0;

        $data = $query->execute()->filter(function($row) use ($colors, $total, &$index){
            $color = $index;
            
            if ($color > $total) {
                $color = 0;
                $index = 0;
            }

            $accent = $colors[$color];

            $index++;

            return array(
                'sheet_id' => $row->lkh_id,
                'sheet_period' => $row->lkh_period, 
                'sheet_fullname' => $row->lkh_su_fullname,
                'sheet_accent' => $accent,
                'sheet_print' => 1
            );
        });

        return array(
            'success' => TRUE,
            'data' => $data
        );

    }

    public function findByIdAction($id) {
        $lkh = Lkh::get($id)->data;

        if ($lkh) {

            $data = $lkh->toArray();
            $data['items'] = $lkh->fetchItems();

            return array(
                'success' => TRUE,
                'data' => $data
            );

        }

        return array(
            'success' => FALSE
        );
    }

}