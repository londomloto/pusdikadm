<?php

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
    'prefix' => '/users/users-statuses',
    'handler' => 'App\Users\Controllers\UsersStatusesController',
    'middleware' => 'auth'
))
->post('/save', 'save');

Router::group(array(
    'prefix' => '/roles/roles-statuses',
    'handler' => 'App\Roles\Controllers\RolesStatusesController',
    'middleware' => 'auth'
))
->post('/save', 'save');

Router::group(array(
    'prefix' => '/surat-masuk',
    'handler' => 'App\SuratMasuk\Controllers\SuratMasukController',
    'middleware' => 'auth'
))
->get('/sequence', 'sequence')
->post('/upload', 'upload');

Router::group(array(
    'prefix' => '/surat-masuk/print',
    'handler' => 'App\SuratMasuk\Controllers\PrintController',
    'middleware' => 'auth'
))
->post('/document/{format}/{id}', 'document')
->post('/report/{format}', 'report');

Router::group(array(
    'prefix' => '/surat-keluar',
    'handler' => 'App\SuratKeluar\Controllers\SuratKeluarController',
    'middleware' => 'auth'
))
->get('/sequence', 'sequence')
->post('/upload', 'upload');

Router::group(array(
    'prefix' => '/surat-keluar/print',
    'handler' => 'App\SuratKeluar\Controllers\PrintController',
    'middleware' => 'auth'
))
->post('/document/{format}/{id}', 'document')
->post('/report/{format}', 'report');