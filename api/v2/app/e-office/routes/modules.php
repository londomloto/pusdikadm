<?php

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
->get('/sequence', 'sequence');

Router::group(array(
    'prefix' => '/surat-keluar',
    'handler' => 'App\SuratKeluar\Controllers\SuratKeluarController',
    'middleware' => 'auth'
))
->get('/sequence', 'sequence');