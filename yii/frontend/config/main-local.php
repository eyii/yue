<?php

$config = [
    'components' => [
        'request' => ['cookieValidationKey' => 'Lf3sJ3jFprI83M6PlUdLA3zePYrHWS7n',],
    ],
];

if (!YII_ENV_TEST) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = ['class' => 'yii\debug\Module',];
    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = ['class' => 'yii\gii\Module', 'allowedIPs' => ['127.0.0.1', '::1', '192.168.83.1'],];
}

return $config;
