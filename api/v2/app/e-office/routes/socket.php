<?php
Router::get('/socket', function(){
    $socket = App::getDefault()->socket;
    $socket->to('/ws-team.go.vm/team')->broadcast('message', array('message' => 'hello'));
});