<?php

Router::group(array(
    'prefix' => '/tasks/tasks-activities',
    'handler' => 'App\Tasks\Controllers\TasksActivitiesController',
    'middleware' => 'auth'
))
->post('/upload', 'upload');