<?php

Router::group(array(
    'prefix' => '/notifications',
    'handler' => 'App\Notifications\Controllers\NotificationsController'
))
->post('/subscribe', 'subscribe')
->post('/unsubscribe', 'unsubscribe')
->post('/notify', 'notify')
->post('/sync', 'sync');

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
->post('/attach', 'attach')
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

Router::group(array(
    'prefix' => '/messages/inbox',
    'handler' => 'App\Messages\Controllers\InboxController',
    'middleware' => 'auth'
))
->get('/info', 'info')
->get('/{code}/read', 'read')
->post('/trash', 'trash')
->post('/remove', 'remove')
->post('/restore', 'restore');

Router::group(array(
    'prefix' => '/messages/outbox',
    'handler' => 'App\Messages\Controllers\OutboxController',
    'middleware' => 'auth'
))
->get('/{code}/open', 'open')
->post('/save', 'save')
->post('/send', 'send')
->post('/trash', 'trash');