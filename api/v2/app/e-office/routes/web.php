<?php

Router::get('/', function(){
    return array(
        'success' => TRUE
    );
});


Router::get('/test/info', function(){
    return array(
        'success' => TRUE
    );
});

Router::get('/test/pdf', function(){
    $pdf = new \Dompdf\Dompdf();
    $pdf->loadHtml('Hello World');
    $pdf->setPaper('A4');

    

    $pdf->render();
    $pdf->stream('pdf.pdf', array('Attachment' => FALSE));
});

Router::get('/test/word', function(){

});

Router::get('/test/excel', function(){
    $xls = new \Micro\Office\Excel(APPPATH.'modules/SuratKeluar/Templates/suratkeluar.xlsx');
    $xls->stream('test.xlsx');

    

});

Router::get('/test/ldap', function(){
    $app = \Micro\App::getDefault();
    $user = $app->ldap->login('roso', '123');
    $app->ldap->logout();
    $user = $app->ldap->login('roso', '123');

});

Router::get('/test/mail', function(){
    
    $mailer = \Micro\App::getDefault()->mailer;
    $send = $mailer->send(array(
        'from' => array('no-reply@worksaurus.com' => 'Worksaurus Admin'),
        'to' => 'roso.sasongko@gmail.com',
        'subject' => 'Test kirim email',
        'body' => 'Hello roso'
    ));

    print_r($send);

});

// example download
Router::post('/home/download', 'App\Home\Controllers\HomeController@download');