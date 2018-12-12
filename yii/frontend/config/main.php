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


    'controllerNamespace' => 'frontend\controllers',
    'components' => [
        'request' => ['csrfParam' => '_csrf-frontend',],
        'session' => ['name' => 'advanced-frontend',],
    ],
    'params' => $params,
];


/*$config['components']['errorHandler']= [

    'errorAction' => '/v1/error/error',
    ];*/
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
      'GET <module:\d+>/<controller:\w+>/search' => '<module>/<controller>/search',
        ['class'         => 'yii\rest\UrlRule',
          'controller'    => ['v1/goods'], 'pluralize'     => false, //false, user 也可访问 true  users 才可访问

        ],
     ['class' => 'yii\rest\UrlRule', 'controller' => 'v1/upload',
         'extraPatterns' => ['OPTIONS,POST    upload' => 'upload',]
     ],

    ],
];

$config['components']['response']=[
    'class'     => 'yii\web\Response',
    'format'=> yii\web\Response::FORMAT_JSON,
    'on beforeSend' => function ($event) {
        $response = $event->sender;
        $response->format = yii\web\Response::FORMAT_JSON;
    },

    'as resBeforeSend' => [
        'class'         => 'frontend\extensions\ResBeforeSendBehavior',
        'defaultCode'   => 500,
        'defaultMsg'    => 'error',
    ],
    //参考 http://www.yiiframework.com/doc-2.0/guide-concept-configurations.html#configuration-format
];
/*$config['components']['request']= ['parsers' => ['application/json' => 'yii\web\JsonParser',]];*/
$config['modules']= ['v1' => ['class' => 'frontend\modules\v1\Module',],];
$config['bootstrap']=  [
    'log',
    [
        'class'     => 'yii\filters\ContentNegotiator',
        'formats' => ['application/json' => yii\web\Response::FORMAT_JSON,
            'application/xml' => yii\web\Response::FORMAT_XML,],
    ]
];

return $config;