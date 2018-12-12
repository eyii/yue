<?php
namespace frontend\modules\v1\controllers;

use common\controllers\ActiveController;
use common\lib\rabbitmq\DownloadJob;
/*yii queue/run

yii queue/listen
$id = Yii::$app->queue->push(new SomeJob());

// Check whether the job is waiting for execution.
Yii::$app->queue->isWaiting($id);

// Check whether a worker got the job from the queue and executes it.
Yii::$app->queue->isReserved($id);

// Check whether a worker has executed the job.
Yii::$app->queue->isDone($id);
@see https://packagist.org/packages/yiisoft/yii2-queue

*/
class JobController extends ActiveController
{
    public function actionPublish(){
        Yii::$app->queue->push(new DownloadJob([
            'url' => 'http://example.com/image.jpg',
            'file' => '/tmp/image.jpg',
        ]));
    }


    public function actionPublishDelay(){
        Yii::$app->queue->delay(5 * 60)->push(new DownloadJob([
            'url' => 'http://example.com/image.jpg',
            'file' => '/tmp/image.jpg',
        ]));
    }
}