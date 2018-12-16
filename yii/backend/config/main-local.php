<?php

$config = [
    'components' => [
        'request' => [
            'cookieValidationKey' => '7MIUF_1u5zzrmSPQtwMsmTckbOtryjiW',
        ],
    ],
];

if (!YII_ENV_TEST) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        'allowedIPs' => ['127.0.0.1', '::1', '10.10.20.165'],
    ];
}

return $config;
