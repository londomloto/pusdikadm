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
    phpinfo();
    exit();
    $xbook = new \ExcelBook('Said M Fahmi', 'linux-edd01c7891abac1006082d3240p0d7u5', TRUE);
    $xbook->setLocale('UTF-8');

    $sheet = $xbook->addSheet('Sheet1');
    $data = [
        [1, 1500, 'John', 'Doe'],
        [2,  750, 'Jane', 'Doe']
    ];

    $row = 1;

    foreach($data as $item){
        $sheet->writeRow($row, $item);
        $row++;
    }

    $path = APPPATH.'public/resources/downloads/test.xlsx';
    $xbook->save($path);


    if (file_exists($path)) {

        $content = file_get_contents($path);

        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="test.xlsx"');
        header('Cache-Control: max-age=0');
        header('Cache-Control: max-age=1');
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
        header('Cache-Control: cache, must-revalidate');
        header('Pragma: public');
        // header('Set-Cookie: download=done; path=/');

        echo $content;
    }

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