<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Task;
use App\Skp\Models\SkpItem;
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

    private function __fetchUsers() {
        static $observables;

        $user = $this->request->getQuery('user');
        $users = array();

        if ($user) {
            $users = array($user);
        } else {
            if ($this->role->can('manage@skp')) {
                $users = array();
            } else {
                if (is_null($observables)) {
                    $observables = array();

                    $module = $this->getDI()->get('App\Skp\Controllers\SkpController', TRUE);
                    $result = $module->observableUsersAction();

                    if ($result->success) {
                        foreach($result->data as $user) {
                            $observables[] = $user['su_id'];
                        }
                    }    
                }
                
                $users = $observables;
            }    
        }

        return $users;
    }

    private function __formatNumber($number, $decimal = 0) {
        return is_null($number) ? NULL : number_format($number, $decimal, ',', '.');
    }

    private function __fetchYears() {
        $start = $this->request->getQuery('start_year');
        $end = $this->request->getQuery('end_year');

        if (empty($start)) {
            $start = date('Y');
        }

        if (empty($end)) {
            $start = $end;
        }

        return array(
            'start_year' => $start,
            'end_year' => $end
        );
    }

    private function __monitoringStat() {
        $users = $this->__fetchUsers();
        $range = $this->__fetchYears();

        $startYear = $range['start_year'];
        $endYear = $range['end_year'];

        $query = User::get()
            ->alias('user')
            ->columns(array(
                'IF( COUNT(skp_item.ski_id) = 0, 1, 0 ) AS outstanding'
            ))
            ->join('App\Skp\Models\Skp', "skp.skp_su_id = user.su_id AND YEAR(skp.skp_start_date) >= '$startYear' AND YEAR(skp.skp_end_date) <= '$endYear'", 'skp', 'LEFT')
            ->join('App\Skp\Models\SkpItem', 'skp_item.ski_skp_id = skp.skp_id', 'skp_item', 'LEFT')
            ->andWhere('user.su_active = 1 AND user.su_incognito = 0')
            ->groupBy('user.su_id');

        if (count($users) > 0) {
            $query->inWhere('user.su_id', $users);
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
                    'description' => 'Pegawai yang belum isi SKP'
                ),
                array(
                    'label' => 'Sudah Isi',
                    'value' => $settled,
                    'total' => $total,
                    'description' => 'Pegawai yang sudah isi SKP'
                )
            );
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );

    }

    private function __statusStat() {
        $users = $this->__fetchUsers();
        $range = $this->__fetchYears();

        $startYear = $range['start_year'];
        $endYear = $range['end_year'];

        $query = KanbanPanel::get()
            ->alias('kanban_panel')
            ->columns(array(
                "MAX(kanban_panel.kp_title) AS label",
                "COUNT(task.skp_id) AS value",
                "CONCAT('Dokumen dalam', ' ', MAX(kanban_panel.kp_title)) AS description"
            ))
            ->join('App\Kanban\Models\KanbanSetting', 'kanban_setting.ks_id = kanban_panel.kp_ks_id', 'kanban_setting', 'LEFT')
            ->join('App\Kanban\Models\KanbanStatus', 'kanban_status.kst_kp_id = kanban_panel.kp_id', 'kanban_status', 'LEFT')
            ->join(
                'App\Skp\Models\TaskStatus', 
                "task_status.sks_status = kanban_status.kst_status AND task_status.sks_deleted = 0 AND YEAR(task_status.sks_created) BETWEEN '$startYear' AND '$endYear'", 
                'task_status', 
                'LEFT'
            );

        $conds = "task.skp_id = task_status.sks_skp_id";

        if (count($users) > 0) {
            $users = implode(',', $users);
            $conds = "task.skp_id = task_status.sks_skp_id AND task.skp_su_id IN ($users)";
        }

        $query
            ->join('App\Skp\Models\Task', $conds, 'task', 'LEFT')
            ->andWhere("kanban_setting.ks_module = 'skp'")
            ->groupBy('kanban_panel.kp_id');

        //print_r($query->getBuilder()->getQuery()->getSql());

        $data = $query->execute()->toArray();

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __volumeStat() {
        $users = $this->__fetchUsers();
        $range = $this->__fetchYears();

        $startYear = $range['start_year'];
        $endYear = $range['end_year'];

        $query = Unit::get()
            ->alias('unit')
            ->columns(array(
                'unit.sun_name AS label',
                'SUM(IF(ISNULL(skp.skp_id), 0, COALESCE(skp_item.ski_volume, 0))) AS target_value',
                'SUM(IF(ISNULL(skp.skp_id), 0, COALESCE(skp_item.ski_volume_real, 0))) AS real_value'
            ))
            ->join('App\Skp\Models\SkpItem', 'skp_item.ski_unit = unit.sun_name', 'skp_item', 'LEFT');

        $conds = "skp.skp_id = skp_item.ski_skp_id AND YEAR(skp.skp_start_date) >= '$startYear' AND YEAR(skp.skp_end_date) <= '$endYear'";

        if (count($users) > 0) {
            $users = implode(',', $users);
            $conds .= " AND skp.skp_su_id IN ($users)";
        }

        $query
            ->join('App\Skp\Models\Skp', $conds, 'skp', 'LEFT')
            ->groupBy('unit.sun_name');

        // print_r($query->getBuilder()->getQuery()->getSql());

        $data = $query->execute()->toArray();

        foreach($data as &$item) {
            $item['target_value_formatted'] = self::__formatNumber($item['target_value']);
            $item['real_value_formatted'] = self::__formatNumber($item['real_value']);
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }   

    private function __costStat() {
        $users = $this->__fetchUsers();
        $range = $this->__fetchYears();

        $startYear = $range['start_year'];
        $endYear = $range['end_year'];

        $query = SkpItem::get()
            ->alias('skp_item')
            ->columns(array(
                'SUM(COALESCE(skp_item.ski_cost, 0)) AS target_value',
                'SUM(COALESCE(skp_item.ski_cost_real, 0)) AS real_value'
            ))
            ->join('App\Skp\Models\Skp', 'skp.skp_id = skp_item.ski_skp_id', 'skp', 'LEFT')
            ->andWhere("YEAR(skp.skp_start_date) >= '$startYear' AND YEAR(skp.skp_end_date) <= '$endYear'");

        if (count($users) > 0) {
            $query->inWhere('skp.skp_su_id', $users);
        }
        
        $data = $query->execute()->filter(function($row){
            return array(
                'description' => 'Biaya kegiatan',
                'label' => 'Biaya',
                'target_value' => $row->target_value,
                'target_value_formatted' => self::__formatNumber($row->target_value),
                'real_value' => $row->real_value,
                'real_value_formatted' => self::__formatNumber($row->real_value)
            );
        });

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __performanceStat() {
        $users = $this->__fetchUsers();
        $range = $this->__fetchYears();

        $startYear = $range['start_year'];
        $endYear = $range['end_year'];

        $query = Task::get()
            ->alias('skp')
            ->columns(array(
                'MAX(user.su_fullname) AS label',
                'MAX(skp.skp_performance) as value'
            ))
            ->join('App\Users\Models\User', 'skp.skp_su_id = user.su_id', 'user')
            ->andWhere("YEAR(skp.skp_start_date) >= '$startYear' AND YEAR(skp.skp_end_date) <= '$endYear'")
            ->orderBy('value DESC')
            ->groupBy('user.su_id')
            ->limit(5);

        if (count($users) > 0) {
            $query->inWhere('skp.skp_su_id', $users);
        }

        $data = $query->execute()->toArray();

        foreach($data as &$item) {
            $item['value_formatted'] = self::__formatNumber($item['value'], 2);
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __behaviorStat() {
        $users = $this->__fetchUsers();
        $range = $this->__fetchYears();

        $startYear = $range['start_year'];
        $endYear = $range['end_year'];

        $query = Task::get()
            ->alias('skp')
            ->columns(array(
                'MAX(user.su_fullname) AS label',
                'MAX(skp.skp_behavior_average) as value'
            ))
            ->join('App\Users\Models\User', 'skp.skp_su_id = user.su_id', 'user')
            ->andWhere("YEAR(skp.skp_start_date) >= '$startYear' AND YEAR(skp.skp_end_date) <= '$endYear'")
            ->orderBy('value DESC')
            ->groupBy('user.su_id')
            ->limit(5);

        if (count($users) > 0) {
            $query->inWhere('skp.skp_su_id', $users);
        }

        $data = $query->execute()->toArray();

        foreach($data as &$item) {
            $item['value_formatted'] = self::__formatNumber($item['value'], 2);
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private function __achievementStat() {
        $users = $this->__fetchUsers();
        $range = $this->__fetchYears();

        $startYear = $range['start_year'];
        $endYear = $range['end_year'];

        $query = Task::get()
            ->alias('skp')
            ->columns(array(
                'MAX(user.su_fullname) AS label',
                'MAX(skp.skp_value) as value'
            ))
            ->join('App\Users\Models\User', 'skp.skp_su_id = user.su_id', 'user')
            ->andWhere("YEAR(skp.skp_start_date) >= '$startYear' AND YEAR(skp.skp_end_date) <= '$endYear'")
            ->orderBy('value DESC')
            ->groupBy('user.su_id')
            ->limit(5);

        if (count($users) > 0) {
            $query->inWhere('skp.skp_su_id', $users);
        }

        $data = $query->execute()->toArray();

        foreach($data as &$item) {
            $item['value_formatted'] = self::__formatNumber($item['value'], 2);
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }
}