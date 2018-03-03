<?php

Router::group(array(
    'prefix' => '/notifications',
    'handler' => 'App\Notifications\Controllers\NotificationsController',
    'middleware' => 'auth'
))
->get('/status', 'status')
->post('/subscribe', 'subscribe')
->post('/unsubscribe', 'unsubscribe')
->post('/notify', 'notify');

Router::group(array(
    'prefix' => '/company',
    'handler' => 'App\Company\Controllers\CompanyController',
    'middleware' => 'auth'
))
->get('/load', 'load')
->post('/upload', 'upload');

Router::group(array(
    'prefix' => '/projects',
    'handler' => 'App\Projects\Controllers\ProjectsController',
    'middleware' => 'auth'
))
->get('/{name}/load', 'load')
->get('/{name}/days', 'days');

Router::group(array(
    'prefix' => '/users/users-panels',
    'handler' => 'App\Users\Controllers\UsersPanelsController',
    'middleware' => 'auth'
))
->post('/save', 'save');

Router::group(array(
    'prefix' => '/roles/roles-panels',
    'handler' => 'App\Roles\Controllers\RolesPanelsController',
    'middleware' => 'auth'
))
->post('/save', 'save');

Router::group(array(
    'prefix' => '/presence',
    'handler' => 'App\Presence\Controllers\PresenceController',
    'middleware' => 'auth'
))
->post('/{id}/upload', 'upload')
->post('/{id}/download', 'download');

Router::group(array(
    'prefix' => '/lkh/exam',
    'handler' => 'App\Lkh\Controllers\ExamController',
    'middleware' => 'auth'
))
->get('/modules', 'modules')
->get('/{id}/flag', 'flag')
->post('/init', 'init');

Router::group(array(
    'prefix' => '/skp/exam',
    'handler' => 'App\Skp\Controllers\ExamController',
    'middleware' => 'auth'
))
->get('/modules', 'modules')
->post('/init', 'init');