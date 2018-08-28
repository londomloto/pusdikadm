<?php

return array(
    'protocol' => 'smtp',
    'type' => 'html',

    'accounts' => array(
        'no-reply' => array('pusdikadm.xyz@gmail.com' => 'Admin Pusdiklat'),
        'admin' => array('pusdikadm.xyz@gmail.com' => 'Admin Pusdiklat'),
        'support' => array('pusdikadm.xyz@gmail.com', 'Admin Pusdiklat')
    ),

    'smtp_host' => 'smtp.gmail.com',
    'smtp_port' => 465,
    'smtp_auth' => true,
    'smtp_user' => 'pusdikadm.xyz',
    'smtp_pass' => 'pu5d1k4dm123',
    'smtp_secure' => 'tls'

    // 'smtp_host' => 'mail.pusdikadm.xyz',
    // 'smtp_port' => 465,
    // 'smtp_auth' => true,
    // 'smtp_user' => 'support',
    // 'smtp_pass' => 'pu5d1k4dm123',
    // 'smtp_secure' => 'none'
    
    // 'smtp_host' => '192.168.0.100',
    // 'smtp_port' => 587,
    // 'smtp_auth' => true,
    // 'smtp_user' => 'support@192.168.0.100',
    // 'smtp_pass' => '123',
    // 'smtp_secure' => 'none'
);