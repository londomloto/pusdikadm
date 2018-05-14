<?php

switch($_SERVER['SERVER_ADMIN']) {
    case 'roso@localhost':
        $databases = array(
            'db' => array(
                // 'host' => '192.168.56.5',
                'host' => 'localhost',
                'user' => 'root',
                'pass' => 'secret',
                'name' => 'e_zip'
            )
        );
        break;
    default:
        $databases = array(
            'db' => array(
                'host' => 'localhost',
                'user' => 'root',
                'pass' => 'secret',
                'name' => 'e_zip'
            )
        );
}

return $databases;