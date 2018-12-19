<?php


header('Access-Control-Allow-Origin:*');
// 响应类型
header('Access-Control-Allow-Methods:*');

header('Access-Control-Allow-Headers:*');
if(strtoupper($_SERVER['REQUEST_METHOD'])== 'OPTIONS'){
    exit;
}
defined('YII_DEBUG') or define('YII_DEBUG', true);
defined('YII_ENV') or define('YII_ENV', 'dev');
/*$json='{"code":"200","msg":"操作成功","data":[{"id":3,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":4,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":5,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":6,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":7,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":8,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":9,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":10,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""},{"id":11,"parent":0,"path":"/","component":"home","name":"主页","icon":"","hidden":0,"redirect":""}]}';
echo $json;
exit();*/
require __DIR__ . '/../../vendor/autoload.php';
require __DIR__ . '/../../vendor/yiisoft/yii2/Yii.php';
require __DIR__ . '/../../common/config/bootstrap.php';
require __DIR__ . '/../config/bootstrap.php';

$config = yii\helpers\ArrayHelper::merge(
    require __DIR__ . '/../../common/config/main.php',
    require __DIR__ . '/../../common/config/main-local.php',
    require __DIR__ . '/../config/main.php',
    require __DIR__ . '/../config/main-local.php'
);

$config['defaultRoute']='/v1/goods';
(new yii\web\Application($config))->run();
