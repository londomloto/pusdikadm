<?php
switch($_SERVER['SERVER_ADMIN']) {
    case 'roso@xampp.local':
        $databases = array(
            'db' => array(
                'host' => 'localhost',
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