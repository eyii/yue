<?php
$config= [
    'aliases' => [
        '@bower' => '@vendor/bower-asset',
        '@npm'   => '@vendor/npm-asset',
    ],
    'vendorPath' => dirname(dirname(__DIR__)) . '/vendor',

];
$config['components' ]["cache"]= ['class' => 'yii\caching\FileCache',];
/*$config['components' ]["authManager"]= [
    "class" => 'yii\rbac\DbManager',
    "defaultRoles" => ["guest"],
];
$config['as access' ]= [
    'class' => 'common\lib\filters\AccessControl',
    'allowActions' => ['*']
];*/
return $config;
