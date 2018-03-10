<?php
namespace Micro\Helpers;

class Text extends \Phalcon\Text {

    private function __construct(){}

    public static function slug($text) {
        $text = preg_replace('~[^\\pL\d]+~u', '-', $text);
        $text = trim($text, '-');
        $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);
        $text = strtolower($text);
        $text = preg_replace('~[^-\w]+~', '', $text);

        if (empty($text)) return '';
        
        return $text;
    }

    public static function initial($words) {
        $part = preg_split('/\s+/', strtolower($words));
        $size = count($part);
        $abbr = '';

        if ($size == 1) {
            $abbr = strtoupper($part[0][0]).(isset($part[0][1]) ? $part[0][1] : '');
        } else {
            for ($i = 0; $i < $size; $i++) {
                if ($i == 0) {
                    $abbr .= strtoupper($part[$i][0]);
                } else {
                    $abbr .= $part[$i][0];
                }
            }    
        }

        return $abbr;
    }

    public static function limitWords($text, $limit) {
        if (str_word_count($text, 0) > $limit) {
            $words = str_word_count($text, 2);
            $pos = array_keys($words);
            $text = substr($text, 0, $pos[$limit]).'...';
        }
        return $text;
    }

    public static function limitText($text, $limit) {

    }

}