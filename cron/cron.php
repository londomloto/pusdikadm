<?php
require 'vendor/autoload.php';

use Phalcon\Di\FactoryDefault\Cli as DI;
use Phalcon\Cli\Console;
use Phalcon\Loader;

$di = new DI();
$loader = new Loader();
$loader->registerDirs(array(
    __DIR__.'/modules'
));
$loader->register();

$config = __DIR__.'/config/config.php';

if (is_readable($config)) {
    $config = include($config);
    $config = new \Phalcon\Config($config);
    
    $di->set('config', $config);
}

$app = new Console();
$app->setDI($di);

$args = array(
    'task' => 'notifications',
    'action' => 'notify',
    'params' => array()
);

try {
    $app->handle($args);
} catch(\Phalcon\Exception $p){
    fwrite(STDERR, $p->getMessage().PHP_EOL);
    exit(1);
} catch(\Throwable $t) {
    fwrite(STDERR, $t->getMessage().PHP_EOL);
    exit(1);
} catch(\Exception $e) {
    fwrite(STDERR, $e->getMessage().PHP_EOL);
    exit(1);
}