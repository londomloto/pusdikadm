<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\LkhDay;
use App\Lkh\Models\LkhItem;
use App\Users\Models\User;
use App\Kanban\Models\KanbanPanel;
use App\Units\Models\Unit;
use Micro\Helpers\Text;

class StatisticController extends \Micro\Controller {

    public function findAction() {
        $display = $this->request->getQuery('display');
        $method = '__'.$display.'Stat';

        if (method_exists($this, $method)) {
            return $this->{$method}();
        } else {
            return array(
                'success' => TRUE,
                'data' => array()
            );
        }
    }

    private function __fetchDateRanges() {
        $start = $this->request->getQuery('start_date');
        $end = $this->request->getQuery('end_date');

        if (empty($start)) {
            $start = date('Y-m-d');
        }

        if (empty($end)) {
            $start = $end;
        }

        return array(
            'start_date' => $start,
            'end_date' => $end
        );
    }

    private function __monitoringStat() {
        $user = $this->request->getQuery('user');
        $range = $this->__fetchDateRanges();
        $startDate = $range['start_date'];
        $endDate = $range['end_date'];

        $query = User::get()
            ->alias('user')
            ->columns(array(
                'IF( COUNT(lkh_item.lki_id) = 0, 1, 0 ) AS outstanding'
            ))
            ->join('App\Lkh\Models\Lkh', "lkh.lkh_su_id = user.su_id", 'lkh', 'LEFT')
            ->join('App\Lkh\Models\LkhDay', "lkh_day.lkd_lkh_id = lkh.lkh_id AND lkh_day.lkd_date BETWEEN '$startDate' AND '$endDate'", 'lkh_day', 'LEFT')
            ->join('App\Lkh\Models\LkhItem', 'lkh_item.lki_lkd_id = lkh_day.lkd_id', 'lkh_item', 'LEFT')
            ->andWhere('user.su_active = 1 AND user.su_incognito = 0')
            ->groupBy('user.su_id');

        if ( ! empty($user)) {
            $query->andWhere('user.su_id = :user:', array('user' => $user));
        }

        //print_r($query->getBuilder()->getQuery()->getSql());

        $result = $query->execute();

        $total = $result->count();
        $outstanding = 0;
        $settled = 0;

        foreach($result as $row) {
            if ($row->outstanding == 1) {
                $outstanding++;
            } else {
                $settled++;
            }
        }

        $data = array();

        if ($total > 0) {
            $data = array(
                array(
                    'label' => 'Belum Isi',
                    'value' => $outstanding,
                    'total' => $total,
                    'description' => 'Belum melakukan pengisian LKH'
                ),
                array(
                    'label' => 'Sudah Isi',
                    'value' => $settled,
                    'total' => $total,
                    'description' => 'Sudah melakukan pengisian LKH'
                )
            );
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );

    }

    private function __statusStat() {
        $user = $this->request->getQuery('user');
        $range = $this->__fetchDateRanges();

        $startDate = $range['start_date'];
        $endDate = $range['end_date'];

        $query = KanbanPanel::get()
            ->alias('kanban_panel')
            ->columns(array(
                "MAX(kanban_panel.kp_title) AS label",
                "COUNT(task_status.lks_id) AS value",
                "CONCAT('Dokumen dalam', ' ', MAX(kanban_panel.kp_title)) AS description"
            ))
            ->join('App\Kanban\Models\KanbanSetting', 'kanban_setting.ks_id = kanban_panel.kp_ks_id', 'kanban_setting', 'LEFT')
            ->join('App\Kanban\Models\KanbanStatus', 'kanban_status.kst_kp_id = kanban_panel.kp_id', 'kanban_status', 'LEFT')
            ->join(
                'App\Lkh\Models\TaskStatus', 
                "task_status.lks_status = kanban_status.kst_status AND task_status.lks_deleted = 0 AND DATE(task_status.lks_created) BETWEEN '$startDate' AND '$endDate'", 
                'task_status', 
                'LEFT'
            );

        $conds = "task.lkh_id = task_status.lks_lkh_id";

        if ( ! empty($user)) {
            $conds = "task.lkh_id = task_status.lks_lkh_id AND task.lkh_su_id = $user";
        }

        $query
            ->join('App\Lkh\Models\Task', $conds, 'task', 'LEFT')
            ->andWhere("kanban_setting.ks_module = 'lkh'")
            ->groupBy('kanban_panel.kp_id');

        //print_r($query->getBuilder()->getQuery()->getSql());

        $data = $query->execute()->toArray();

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __volumeStat() {
        $user = $this->request->getQuery('user');
        $range = $this->__fetchDateRanges();
        $startDate = $range['start_date'];
        $endDate = $range['end_date'];

        $query = Unit::get()
            ->alias('unit')
            ->columns(array(
                'unit.sun_name AS label',
                'SUM(IF(ISNULL(task.lkh_id), 0, COALESCE(lkh_item.lki_volume, 0))) AS value'
            ))
            ->join('App\Lkh\Models\LkhItem', 'lkh_item.lki_unit = unit.sun_name', 'lkh_item', 'LEFT')
            ->join(
                'App\Lkh\Models\LkhDay', 
                "lkh_day.lkd_id = lkh_item.lki_lkd_id AND lkh_day.lkd_date BETWEEN '$startDate' AND '$endDate'", 
                'lkh_day', 
                'LEFT'
            );

        $conds = "task.lkh_id = lkh_day.lkd_lkh_id";

        if ( ! empty($user)) {
            $conds = "task.lkh_id = lkh_day.lkd_lkh_id AND task.lkh_su_id = $user";
        }

        $query
            ->join('App\Lkh\Models\Task', $conds, 'task', 'LEFT')
            ->groupBy('unit.sun_name');

        // print_r($query->getBuilder()->getQuery()->getSql());

        $data = $query->execute()->toArray();

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __costStat() {
        $user = $this->request->getQuery('user');

        $range = $this->__fetchDateRanges();
        $startDate = $range['start_date'];
        $endDate = $range['end_date'];

        $query = LkhItem::get()
            ->alias('lkh_item')
            ->columns(array(
                'SUM(COALESCE(lkh_item.lki_cost, 0)) AS value'
            ))
            ->join('App\Lkh\Models\LkhDay', 'lkh_day.lkd_id = lkh_item.lki_lkd_id', 'lkh_day', 'LEFT')
            ->join('App\Lkh\Models\Task', 'task.lkh_id = lkh_day.lkd_lkh_id', 'task', 'LEFT')
            ->andWhere("lkh_day.lkd_date BETWEEN '$startDate' AND '$endDate'");

        if ( ! empty($user)) {
            $query->andWhere('task.lkh_su_id = :user:', array('user' => $user));
        }
        
        $data = $query->execute()->filter(function($row){
            return array(
                'description' => 'Penggunaan biaya dalam kegiatan',
                'label' => 'Biaya',
                'value' => $row->value,
                'value_formatted' => number_format($row->value, 0, ',', '.')
            );
        });

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __performanceStat() {
        $user = $this->request->getQuery('user');
        $range = $this->__fetchDateRanges();

        $startDate = $range['start_date'];
        $endDate = $range['end_date'];

        $query = LkhDay::get()
            ->alias('lkh_day')
            ->columns(array(
                'DATEDIFF(lkh_day.lkd_created_dt, lkh_day.lkd_date) AS aging'
            ))
            ->join(
                'App\Lkh\Models\Task', 
                'task.lkh_id = lkh_day.lkd_lkh_id', 
                'task', 
                'LEFT'
            )
            ->andWhere("lkh_day.lkd_date BETWEEN '$startDate' AND '$endDate'");

        if ( ! empty($user)) {
            $query->andWhere('task.lkh_su_id = :user:', array('user' => $user));
        }

        $result = $query->execute();

        $class = array(
            'A' => array(
                'label' => '0-1 Hari',
                'value' => 0,
                'description' => 'Pengisian tepat waktu (0-1 hari)'
            ),
            'B' => array(
                'label' => '2-6 Hari',
                'value' => 0,
                'description' => 'Pengisian 2-6 hari'
            ),
            'C' => array(
                'label' => '7-14 Hari',
                'value' => 0,
                'description' => 'Pengisian 7-14 hari'
            ),
            'D' => array(
                'label' => '15-30 Hari',
                'value' => 0,
                'description' => 'Pengisian 15-30 hari'
            ),
            'E' => array(
                'label' => 'Tidak Valid',
                'value' => 0,
                'description' => 'Pengisian tidak valid'
            )
        );

        foreach($result as $row) {
            if ($row->aging >= 0 AND $row->aging <= 1) {
                $class['A']['value']++;
            } else if ($row->aging >= 2 && $row->aging <= 6) {
                $class['B']['value']++;
            } else if ($row->aging >= 7 && $row->aging <= 14) {
                $class['C']['value']++;
            } else if ($row->aging >= 15 && $row->aging <= 31) {
                $class['D']['value']++;
            } else if ($row->aging < 0) {
                $class['E']['value']++;
            }
        }

        $data = array_values($class);

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __productivityStat() {
        $user = $this->request->getQuery('user');
        $range = $this->__fetchDateRanges();

        $startDate = $range['start_date'];
        $endDate = $range['end_date'];

        $query = LkhItem::get()
            ->alias('lkh_item')
            ->columns(array(
                "IF(ISNULL(unit.sun_id), 'B', 'A') AS type"
            ))
            ->join('App\Units\Models\Unit', 'unit.sun_name = lkh_item.lki_unit', 'unit', 'LEFT')
            ->join('App\Lkh\Models\LkhDay', 'lkh_day.lkd_id = lkh_item.lki_lkd_id', 'lkh_day', 'LEFT')
            ->join('App\Lkh\Models\Task', 'task.lkh_id = lkh_day.lkd_lkh_id', 'task', 'LEFT')
            ->andWhere("lkh_day.lkd_date BETWEEN '$startDate' AND '$endDate'");

        if ( ! empty($user)) {
            $query->andWhere('task.lkh_su_id = :user:', array('user' => $user));
        }

        $groups = array(
            'A' => array(
                'label' => 'Produktif',
                'value' => 0,
                'description' => 'Kegiatan produktif'
            ),
            'B' => array(
                'label' => 'Non-Produktif',
                'value' => 0,
                'description' => 'Kegiatan non-produktif'
            )
        );

        $result = $query->execute();

        foreach($result as $row) {
            if ($row->type == 'A') {
                $groups['A']['value']++;
            } else if ($row->type == 'B') {
                $groups['B']['value']++;
            }
        }

        $data = array_values($groups);

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }
}