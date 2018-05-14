<?php

Router::group(array(
    'prefix' => '/activities',
    'handler' => 'App\Activities\Controllers\ActivitiesController',
    'middleware' => 'auth'
))
->post('/upload', 'upload');

Router::group(array(
    'prefix' => '/notifications',
    'handler' => 'App\Notifications\Controllers\NotificationsController'
))
->get('/{user}/summary', 'summary')
->post('/subscribe', 'subscribe')
->post('/unsubscribe', 'unsubscribe')
->post('/sync', 'sync')
->post('/{id}/notify', 'notify')
->post('/{id}/read', 'read');

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
    'prefix' => '/users',
    'handler' => 'App\Users\Controllers\UsersController',
    'middleware' => 'auth'
))
->get('/{id}/superiors', 'superiors');

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

// SKP

Router::group(array(
    'prefix' => '/skp',
    'handler' => 'App\Skp\Controllers\SkpController',
    'middleware' => 'auth'
))
->get('/observable-users', 'observableUsers')
->get('/grouped-statuses', 'groupedStatuses')
->post('/{id}/save-behaviors', 'saveBehaviors');

Router::group(array(
    'prefix' => '/skp/skp-items',
    'handler' => 'App\Skp\Controllers\SkpItemsController',
    'middleware' => 'auth'
))
->post('/save-batch', 'saveBatch');

Router::group(array(
    'prefix' => '/skp/print',
    'handler' => 'App\Skp\Controllers\PrintController',
    'middleware' => 'auth'
))
->post('/document/{format}/{id}', 'document')
->post('/report/{format}', 'report')
->post('/database/{format}', 'database')
->post('/database-items/{format}', 'databaseItems')
->post('/dashboard/{format}', 'dashboard');

Router::group(array(
    'prefix' => '/skp/dashboard',
    'handler' => 'App\Skp\Controllers\DashboardController',
    'middleware' => 'auth'
))
->post('/save', 'save');

Router::group(array(
    'prefix' => '/skp/live',
    'handler' => 'App\Skp\Controllers\LiveController',
    'middleware' => 'auth'
))
->post('/alert', 'alert');

// MODULE: LKH

Router::group(array(
    'prefix' => '/lkh',
    'handler' => 'App\Lkh\Controllers\LkhController',
    'middleware' => 'auth'
))
->get('/observable-users', 'observableUsers')
->get('/grouped-statuses', 'groupedStatuses');

Router::get('/lkh/alert', 'App\Lkh\Controllers\LkhController@alert');

Router::group(array(
    'prefix' => '/lkh/lkh-items',
    'handler' => 'App\Lkh\Controllers\LkhItemsController',
    'middleware' => 'auth'
))
->post('/{id}/upload', 'upload');

Router::group(array(
    'prefix' => '/lkh/lkh-items',
    'handler' => 'App\Lkh\Controllers\LkhItemsController',
    'middleware' => 'auth'
))
->post('/{id}/upload', 'upload');

Router::group(array(
    'prefix' => '/lkh/live',
    'handler' => 'App\Lkh\Controllers\LiveController',
    'middleware' => 'auth'
))
->post('/alert', 'alert');

Router::group(array(
    'prefix' => '/lkh/report',
    'handler' => 'App\Lkh\Controllers\ReportController',
    'middleware' => 'auth'
))
->get('/sheets', 'sheets')
->post('/alert', 'alert');

Router::group(array(
    'prefix' => '/lkh/print',
    'handler' => 'App\Lkh\Controllers\PrintController',
    'middleware' => 'auth'
))
->post('/document/{id}/{format}', 'document')
->post('/report/{format}', 'report')
->post('/database/{format}', 'database')
->post('/database-items/{format}', 'databaseItems')
->post('/dashboard/{format}', 'dashboard');

Router::group(array(
    'prefix' => '/lkh/dashboard',
    'handler' => 'App\Lkh\Controllers\DashboardController',
    'middleware' => 'auth'
))
->post('/save', 'save');

// REGIS
Router::group(array(
    'prefix' => '/registration',
    'handler' => 'App\Registration\Controllers\RegistrationController',
    'middleware' => 'auth'
))
->get('/observable-users', 'observableUsers')
->get('/grouped-statuses', 'groupedStatuses');

Router::group(array(
    'prefix' => '/registration/print',
    'handler' => 'App\Registration\Controllers\PrintController',
    'middleware' => 'auth'
))
->post('/document/{id}/{format}', 'document')
->post('/report/{format}', 'report')
->post('/database/{format}', 'database')
->post('/database-items/{format}', 'databaseItems')
->post('/dashboard/{format}', 'dashboard');