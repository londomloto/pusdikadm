<?php
namespace App\Presence\Controllers;

use App\Presence\Models\Presence;
use App\Presence\Models\PresenceType;
use App\Calendar\Models\Calendar;
use App\Users\Models\User;
use Micro\Helpers\Date as DateHelper;

class ChartController extends \Micro\Controller {

    public function findAction() {
        $chart = $this->request->getQuery('chart');

        switch($chart) {
            case 'pie':
                return $this->pie();
            case 'bar':
                return $this->bar();
            case 'tab':
                return $this->tab();
        }
    }

    public function pie() {
        $today = DateHelper::today();
        $from = $today->cloning()->startOf('month');
        $to = $today->cloning()->endOf('month');

        Calendar::fillRange($from->format('Y-m-d'), $to->format('Y-m-d'));
        $params = json_decode($this->request->getQuery('params'), TRUE);

        $filter = sprintf(
            sprintf(
                "presence_type.tpt_name = presence.tpr_type AND presence.tpr_date BETWEEN '%s' AND '%s'", 
                $from->format('Y-m-d'), 
                $to->format('Y-m-d')
            )
        );

        $title = 'Persentase Absensi';

        if (isset($params['user']) && ! empty($params['user'])) {
            $user = User::findFirst($params['user']);
            
            if ($user) {
                $title = 'Persentase '.$user->getName();
            }

            $filter .= ' AND presence.tpr_su_id = '.$params['user'];
        }

        $query = PresenceType::get()
            ->alias('presence_type')
            ->columns(array(
                'presence_type.tpt_name AS label',
                'count(presence.tpr_id) AS value'
            ))
            ->join(
                'App\Presence\Models\Presence', 
                $filter,
                'presence', 
                'left'
            )
            ->groupBy('presence_type.tpt_name')
            ->orderBy('presence_type.tpt_name');

        $result = $query->execute();

        $serie = array(
            'name' => 'percentage',
            'data' => array()
        );

        foreach($result as $row) {
            $serie['data'][] = array(
                'name' => $row->label,
                'y' => (int)$row->value
            );
        }

        if ($from->format('MY') == $to->format('MY')) {
            $subtitle = 'Periode '.$from->format('d').' s/d '.$to->format('d').' '.$from->format('M Y');
        } else {
            $subtitle = 'Periode '.$from->format('d M Y').' s/d '.$to->format('d M Y');
        }

        $data = array(
            'title' => $title,
            'subtitle' => $subtitle,
            'series' => array($serie)
        );

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    public function bar() {
        $today = DateHelper::today();
        
        $from = $today->cloning()->startOf('year');
        $to = $today->cloning()->endOf('year');

        Calendar::fillRange($from->format('Y-m-d'), $to->format('Y-m-d'));

        $groups = Calendar::get()
            ->columns('sdt_group')
            ->where('sdt_date BETWEEN :from: AND :to:', array(
                'from' => $from->format('Y-m-d'),
                'to' => $to->format('Y-m-d')
            ))
            ->groupBy('sdt_group')
            ->execute()
            ->toArray();

        $categories = array();
        $series = array();
        $inyear = $from->format('Y') == $to->format('Y');

        $params = json_decode($this->request->getQuery('params'), TRUE);
        $user = (isset($params['user']) && ! empty($params['user'])) ? User::findFirst($params['user']) : FALSE;

        $title = 'Statistik Absensi';

        if ($user) {
            $title = 'Statistik '.$user->getName();
        }

        foreach($groups as $group) {
            $offset = DateHelper::create($group['sdt_group'].'-01');
            $name = $inyear ? $offset->format('M') : $offset->format('M Y');
            $categories[$name] = array(
                'from' => $offset->startOf('month')->format('Y-m-d'),
                'to' => $offset->endOf('month')->format('Y-m-d')
            );
        }

        foreach(PresenceType::find() as $type) {
            $name = $type->tpt_name;
            $series[$name] = array(
                'name' => $name,
                'data' => array()
            );

            foreach($categories as $cat) {
                $query = Presence::get()
                    ->andWhere('tpr_type = :name:', array('name' => $name))
                    ->andWhere('tpr_date BETWEEN :from: and :to:', array(
                        'from' => $cat['from'],
                        'to' => $cat['to']
                    ));

                if ($user) {
                    $query->andWhere('tpr_su_id = :user:', array('user' => $user->su_id));
                }

                $result = $query->execute();

                $value = $result->count();
                $series[$name]['data'][] = $value;
            }
        }

        $series = array_values($series);
        $categories = array_keys($categories);

        if ($from->format('Y') == $to->format('Y')) {
            $subtitle = 'Periode '.$from->format('d M').' s/d '.$to->format('d M').' '.$from->format('Y');
        } else {
            $subtitle = 'Periode '.$from->fromat('d M Y').' s/d '.$to->format('d M Y');
        }

        $data = array(
            'title' => $title,
            'subtitle' => $subtitle,
            'categories' => $categories,
            'series' => $series
        );

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    public function tab() {

    }

}