<?php

switch($_SERVER['SERVER_ADMIN']) {
    case 'roso@localhost':
        $databases = array(
            'db' => array(
                'host' => '192.168.56.5',
                'user' => 'root',
                'pass' => 'secret',
                'name' => 'e_lkh'
            )
        );
        break;
    default:
        $databases = array(
            'db' => array(
                'host' => 'localhost',
                'user' => 'root',
                'pass' => 'secret',
                'name' => 'e_lkh'
            )
        );
}

return $databases;