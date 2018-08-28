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
->get('/{id}/superiors', 'superiors')
->get('/{id}/subordinates', 'subordinates');

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

// JOBS
Router::group(array(
    'prefix' => '/jobs',
    'handler' => 'App\Jobs\Controllers\JobsController',
    'middleware' => 'auth'
))
->get('/{id}/subordinates', 'subordinates');

// SURAT MASUK
Router::group(array(
    'prefix' => '/surat-masuk',
    'handler' => 'App\SuratMasuk\Controllers\SuratMasukController',
    'middleware' => 'auth'
))
->get('/grouped-statuses', 'groupedStatuses')
->get('/origins', 'origins')
->get('/{id}/authors', 'authors')
->get('/{id}/outstandings', 'outstandings')
->post('/{id}/send', 'send')
->post('/{id}/receive', 'receive')
->post('/{id}/notify', 'notify')
->post('/upload', 'upload');

Router::group(array(
    'prefix' => '/surat-masuk/print',
    'handler' => 'App\SuratMasuk\Controllers\PrintController',
    'middleware' => 'auth'
))
->post('/document/{format}/{id}', 'document')
->post('/document-receipt/{format}/{id}', 'documentReceipt')
->post('/document-distributions/{format}/{id}', 'documentDistributions')
->post('/disposition/{format}/{id}', 'disposition')
->post('/database/{format}', 'database');

Router::group(array(
    'prefix' => '/surat-masuk/distributions',
    'handler' => 'App\SuratMasuk\Controllers\DistributionsController',
    'middleware' => 'auth'
))
->post('/{id}/signature', 'signature');

// SURAT KELUAR
Router::group(array(
    'prefix' => '/surat-keluar',
    'handler' => 'App\SuratKeluar\Controllers\SuratKeluarController',
    'middleware' => 'auth'
))
->get('/grouped-statuses', 'groupedStatuses')
->get('/destinations', 'destinations')
->get('/{id}/authors', 'authors')
->get('/{id}/load-signature', 'loadSignature')
->post('/{id}/notify', 'notify')
->post('/upload', 'upload')
->post('/{id}/signature', 'signature')
->post('/{id}/save-signature', 'saveSignature');

Router::group(array(
    'prefix' => '/surat-keluar/surat-keluar-exams',
    'handler' => 'App\SuratKeluar\Controllers\SuratKeluarExamsController',
    'middleware' => 'auth'
))
->post('/{id}/signature', 'signature');

Router::group(array(
    'prefix' => '/surat-keluar/print',
    'handler' => 'App\SuratKeluar\Controllers\PrintController',
    'middleware' => 'auth'
))
->post('/document/{format}/{id}', 'document')
->post('/database/{format}', 'database');