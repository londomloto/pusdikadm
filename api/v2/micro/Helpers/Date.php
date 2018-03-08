<?php
namespace Micro\Helpers;

use Moment\Moment;

class Date {

    public static function today() {
        return new Moment();
    }

    public static function create($date) {
        return new Moment($date);
    }

    public static function format($date, $format = 'd M Y H:i') {
        if (empty($date)) {
            return '';
        }
        $date = new Moment(strtotime($date));
        return $date->format($format);
    }

    public static function formatRelative($date, $format = 'd M Y H:i') {
        $date = new Moment(strtotime($date));
        $diff = $date->fromNow();

        if ($diff->getDirection() == 'past') {
            return $diff->getRelative();
        } else {
            return $date->format($format);
        }
    }

}