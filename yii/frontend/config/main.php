<?php
$params = array_merge(
    require __DIR__ . '/../../common/config/params.php',
    require __DIR__ . '/../../common/config/params-local.php',
    require __DIR__ . '/params.php',
    require __DIR__ . '/params-local.php'
);

$config= [
    'id' => 'app-frontend',
    'basePath' => dirname(__DIR__),
    'bootstrap' => [
        'log',
        [
            'class'     => 'yii\filters\ContentNegotiator',
            'formats' => ['application/json' => yii\web\Response::FORMAT_JSON, 'application/xml' => yii\web\Response::FORMAT_XML,],
        ]
    ],

    'controllerNamespace' => 'frontend\controllers',
    'components' => [
        'request' => ['csrfParam' => '_csrf-frontend',],
        'session' => ['name' => 'advanced-frontend',],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [['class' => 'yii\log\FileTarget',
                'levels' => ['error', 'warning'],],],
        ],


    ],
    'params' => $params,
];


//$config['components']['errorHandler']= ['errorAction' => 'site/error',];
$config['components']['user']= [
    'identityClass'     => 'frontend\models\User',
    'enableAutoLogin'   => false,
    'enableSession'     => false,
    'loginUrl'          => null,
];
$config['components']['urlManager']=[
    'enablePrettyUrl'       => true,
    'enableStrictParsing'   => true,
    'showScriptName'        => true,
   'rules' => [
        'GET <module:(v)\d+>/<controller:\w+>/search' => '<module>/<controller>/search',
        ['class'         => 'yii\rest\UrlRule', 'controller'    => ['v1/goods'], 'pluralize'     => false, //false, user 也可访问 true  users 才可访问
        ],
    ],
];
$config['components']['response']=[
    'class'     => 'yii\web\Response',
    'as resBeforeSend' => [
        'class'         => 'frontend\extensions\ResBeforeSendBehavior',
        'defaultCode'   => 500,
        'defaultMsg'    => 'error',
    ],
    //参考 http://www.yiiframework.com/doc-2.0/guide-concept-configurations.html#configuration-format
];
$config['modules']= ['v1' => ['class' => 'frontend\modules\v1\Module',],];

return $config;