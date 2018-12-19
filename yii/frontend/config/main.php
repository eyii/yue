<?php

use frontend\libs\ResBeforeSendBehavior;

$params = array_merge(
    require __DIR__ . '/../../common/config/params.php',
    require __DIR__ . '/../../common/config/params-local.php',
    require __DIR__ . '/params.php',
    require __DIR__ . '/params-local.php'
);

$config= [
    'id' => 'app-frontend',
    'basePath' => dirname(__DIR__),


    'controllerNamespace' => 'frontend\controllers',
    'components' => [
        'request' => ['csrfParam' => '_csrf-frontend',],
        'session' => ['name' => 'advanced-frontend',],
    ],
    'params' => $params,
];



$config['components']['user']= [
    'identityClass'     => 'frontend\models\User',
    'enableAutoLogin'   => false,
    'enableSession'     => false,
    'loginUrl'          => null,
];
$config['components']['log']= [
    'traceLevel' => YII_DEBUG ? 3 : 0,
    'targets' => [['class' => 'yii\log\FileTarget',
        'levels' => ['error', 'warning'],],],
];
$config['components']['urlManager']=[
    'enablePrettyUrl' => true,
    'showScriptName' => false,
 'rules' => [
     'GET <module:\w+>/<controller:\w+>/<id:\d+>' => '<module>/<controller>/view',
     'POST <module:\w+>/<controller:\w+>' => '<module>/<controller>/create',
     'DELETE <module:\w+>/<controller:\w+>/<id:\d+>' => '<module>/<controller>/delete',
     'PATCH <module:\w+>/<controller:\w+>/<id:\d+>' => '<module>/<controller>/update',
     'OPTIONS <module:\w+>/<controller:\w+>/<id:\d+>' => '<module>/<controller>/options',
     ['class' => 'yii\rest\UrlRule', 'controller' => '*', 'pluralize' => false],
     /*   ['class'         => 'yii\rest\UrlRule',
          'controller'    => ['v1/goods'], 'pluralize'     => false, //false, user 也可访问 true  users 才可访问

        ],
     ['class' => 'yii\rest\UrlRule',
         'controller' => 'v1/upload',
         'extraPatterns' => ['OPTIONS,POST    upload' => 'upload',
      ]
     ],*/

    ],
];

$config['components']['response']=[
    'class'     => 'common\lib\rest\Response',
    'format'=> common\lib\rest\Response::FORMAT_JSON,
    'as resBeforeSend' => [
        'class'         => ResBeforeSendBehavior::className(),
        'code'   => 500,
        'msg'    => 'error',
    ],
    //参考 http://www.yiiframework.com/doc-2.0/guide-concept-configurations.html#configuration-format
];
$config['components']['request']= [
    'class' => 'common\lib\di\Request',
    'parsers' => ['application/json' => 'yii\web\JsonParser',]
];
$config['components']['authManager']= ['class' => 'yii\rbac\PhpManager',];
$config['components']['errorHandler']= ['class' => 'common\lib\di\ErrorHandler',];
$config['modules']['v1']= ['class' => 'frontend\modules\v1\Module',];
$config['bootstrap']=  [
    'log',
    [
        'class'     => 'yii\filters\ContentNegotiator',
        'formats' => [
            'application/json' => yii\web\Response::FORMAT_JSON,
            'application/xml' => yii\web\Response::FORMAT_XML,
            ],
    ]
];

return $config;