<?php

return array(
    'protocol' => 'smtp',
    'type' => 'html',

    'accounts' => array(
        'no-reply' => array('support@pusdikadm.xyz' => 'Admin Pusdiklat'),
        'admin' => array('support@pusdikadm.xyz' => 'Admin Pusdiklat'),
        'support' => array('support@pusdikadm.xyz', 'Admin Pusdiklat')
    ),
    
    // 'smtp_host' => 'mail.smartfren.com',
    // 'smtp_port' => 25,

    'smtp_host' => 'mail.pusdikadm.xyz',
    'smtp_port' => 465,

    'smtp_auth' => true,
    'smtp_user' => 'support',
    'smtp_pass' => 'pu5d1k4dm123',
    'smtp_secure' => 'none'
);