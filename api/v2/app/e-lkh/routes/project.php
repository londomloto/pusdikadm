<?php

Router::group(array(
    'prefix' => '/projects',
    'handler' => 'App\Projects\Controllers\ProjectsController',
    'middleware' => 'auth'
))
->get('/load/{name}', 'load');

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