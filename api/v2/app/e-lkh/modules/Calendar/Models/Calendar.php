<?php
namespace App\Calendar\Models;

class Calendar extends \Micro\Model {

    public function getSource() {
        return 'sys_calendar';
    }

    public static function fill($month = NULL, $year = NULL) {
        if (is_null($month)) {
            $month = date('m');
        }

        if (is_null($year)) {
            $year = date('Y');
        }

        $group = sprintf("%'.04d-%'.02d", $year, $month);

        $found = self::findFirst(array(
            'sdt_group = :group:',
            'bind' => array(
                'group' => $group
            )
        ));

        $offset = sprintf("%'.04d-%'.02d-%'.02d", $year, $month, 1);
        $offset = new \Moment\Moment($offset);

        $start = $offset->cloning()->startOf('month');
        $end = $offset->cloning()->endOf('month');

        if ( ! $found) {
            $diff = $start->from($end);
            $days = $diff->getDays();
            $date = $start->cloning();

            for ($i = 0; $i < $days; $i++) {
                $cal = new Calendar();

                $cal->sdt_date = $date->format('Y-m-d');
                $cal->sdt_group = $group;
                $cal->save();

                $date->addDays(1);
            }
        }

        return array(
            'start' => $start->format('Y-m-d'),
            'end' => $end->format('Y-m-d')
        );
    }

    public static function fillRange($from, $to) {
        $from = new \Moment\Moment($from);
        $to = new \Moment\Moment($to);
        $diff = ($from->from($to)->getMonths() - 1);

        if ($diff > 0) {
            $date = $from->cloning()->startOf('month');

            for ($i = 0; $i < $diff; $i++) {
                Calendar::fill($date->format('m'), $date->format('Y'));
                $date->addMonths(1);
            }
        } else {
            Calendar::fill($from->format('m'), $from->format('Y'));
        }
    }
}