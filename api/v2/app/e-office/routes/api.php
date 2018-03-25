<?php

Router::group(array(
    'prefix' => '/system',
    'handler' => 'App\System\Controllers\SystemController',
    'middleware' => 'auth'
))
->post('/backup', 'backup');

/**
 * module: config
 */
Router::group(array(
    'prefix' => '/config',
    'handler' => 'App\Config\Controllers\ConfigController',
    'middleware' => 'auth'
))
->get('/load-package', 'loadPackage')
->post('/save-package', 'savePackage')
->post('/save', 'save');

Router::get('/config/session', 'App\Config\Controllers\ConfigController@session');
Router::get('/config/routes', 'App\Config\Controllers\ConfigController@routes');
Router::get('/config/load', 'App\Config\Controllers\ConfigController@load');

/**
 * module: auth
 */
Router::group(array(
    'prefix' => '/auth',
    'handler' => 'App\Auth\Controllers\AuthController',
    'middleware' => 'auth'
))
->get('/user', 'user')
->get('/validate', 'validate')
->get('/validate-password', 'validatePassword');

Router::get('/auth/test', 'App\Auth\Controllers\AuthController@test');
Router::get('/auth/captcha', 'App\Auth\Controllers\AuthController@captcha');
Router::get('/auth/tesemail', 'App\Auth\Controllers\AuthController@tesemail');
Router::post('/auth/login', 'App\Auth\Controllers\AuthController@login');
Router::post('/auth/recover', 'App\Auth\Controllers\AuthController@recover');
Router::post('/auth/validate-reset', 'App\Auth\Controllers\AuthController@validateReset');
Router::post('/auth/reset', 'App\Auth\Controllers\AuthController@reset');

/**
 * module: assets
 */
Router::get('/assets/thumb', 'App\Assets\Controllers\AssetsController@thumb');
Router::get('/assets/download', 'App\Assets\Controllers\AssetsController@download');

/**
 * module: profile
 */
Router::group(array(
    'prefix' => '/profile',
    'handler' => 'App\Profile\Controllers\ProfileController',
    'middleware' => 'auth'
))
->post('/{id}/upload', 'upload');

/**
 * module: users
 */
Router::group(array(
    'prefix' => '/users',
    'handler' => 'App\Users\Controllers\UsersController',
    'middleware' => 'auth'
))
->post('/{id}/upload', 'upload')
->post('/invite', 'invite')
->post('/reinvite', 'reinvite');

Router::get('/users/test', 'App\Users\Controllers\UsersController@test');
Router::post('/users/validate-activation', 'App\Users\Controllers\UsersController@validateActivation');
Router::post('/users/activate', 'App\Users\Controllers\UsersController@activate');
