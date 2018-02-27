<?php

Router::group(array(
    'prefix' => '/feed',
    'handler' => 'App\Feed\Controllers\FeedController',
    'middleware' => 'auth'
))
->post('/register', 'register');