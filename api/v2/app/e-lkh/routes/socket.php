<?php
Router::get('/socket', function(){
    $socket = App::getDefault()->socket;
    $socket->to('/localhost/pusdikadm/e-lkh')->broadcast('notify');
});