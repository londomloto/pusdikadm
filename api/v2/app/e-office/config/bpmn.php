<?php
return array(
    
    'providers' => array(
        'diagram' => 'App\Bpmn\Models\Diagram',
        'shape' => 'App\Bpmn\Models\Shape',
        'link' => 'App\Bpmn\Models\Link'
    ),
    
    'models' => array(
        'proses-surat-masuk' => 'App\Inbox\Models\Inbox',
        'proses-surat-keluar' => 'App\Outbox\Models\Outbox'
    )
);