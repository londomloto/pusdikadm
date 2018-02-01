<?php
return array(
    
    'providers' => array(
        'diagram' => 'App\Bpmn\Models\Diagram',
        'shape' => 'App\Bpmn\Models\Shape',
        'link' => 'App\Bpmn\Models\Link'
    ),
    'models' => array(
        'proses-pendaftaran' => 'App\Users\Models\User',
        'proses-absensi' => 'App\Presence\Models\Presence',
        'proses-dokumen-lkh' => 'App\Lkh\Models\Lkh',
        'proses-periksa-lkh' => 'App\Lkh\Models\LkhCheck',
        'proses-dokumen-skp' => 'App\Skp\Models\Skp',
        'proses-periksa-skp' => 'App\Skp\Models\SkpCheck'
    )
);