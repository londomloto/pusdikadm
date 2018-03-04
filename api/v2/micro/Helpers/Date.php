<?php
namespace Micro\Helpers;

class Date {

    public static function format($date, $format = 'd M Y H:i') {
        if (empty($date)) {
            return '';
        }
        $date = new \Moment\Moment(strtotime($date));
        return $date->format($format);
    }

    public static function formatRelative($date, $format = 'd M Y H:i') {
        $date = new \Moment\Moment(strtotime($date));
        $diff = $date->fromNow();

        if ($diff->getDirection() == 'past') {
            return $diff->getRelative();
        } else {
            return $date->format($format);
        }
    }

}