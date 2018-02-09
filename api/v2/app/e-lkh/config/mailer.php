<?php

return array(
    'protocol' => 'smtp',
    'type' => 'html',

    'accounts' => array(
        'no-reply' => array('no-reply@pusdikadm.xyz' => 'Admin Pusdiklat'),
        'admin' => array('admin@pusdikadm.xyz' => 'Admin Pusdiklat'),
        'support' => array('support@pusdikadm.xyz', 'Webmaster Pusdiklat')
    ),
    
    // 'smtp_host' => 'mail.smartfren.com',
    // 'smtp_port' => 25,

    'smtp_host' => 'mail.pusdikadm.xyz',
    'smtp_port' => 587,

    'smtp_auth' => true,
    'smtp_user' => 'support',
    'smtp_pass' => 'pu5d1k4dm123',
    'smtp_secure' => 'tls'
);