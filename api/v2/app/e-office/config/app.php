<?php

return array(
    
    'debug' => FALSE,

    'version' => '2.0.0',

    'env' => 'DEVELOPMENT',

    'author' => 'PUSDIKADM',

    'timezone' => 'Asia/Jakarta',

    'locale' => 'id_ID',

    'secret' => '279nBsxjS77rmJzQbHEFWA==',

    'providers' => array(
        'auth' => 'Micro\Auth\AuthProvider',
        'role' => 'Micro\Role\RoleProvider',
        'file' => 'Micro\File\FileProvider',
        'bpmn' => 'Micro\Bpmn\BpmnProvider',
        'ldap' => 'Micro\Ldap\LdapProvider',
        'dx'   => 'Micro\Dx\DxProvider',
        'socket' => 'Micro\Socket\SocketProvider'
    ),

    'middleware' => array(
        'auth' => 'Micro\Auth\AuthMiddleware'
    ),

    'aliases' => array(
        'User' => 'App\Users\Models\User'
    )

);