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

    'smtp_host' => 'pusdikadm.xyz',
    'smtp_port' => 587,

    'smtp_auth' => true,
    'smtp_user' => 'admin',
    'smtp_pass' => 'secret',
    'smtp_secure' => 'tls'
);