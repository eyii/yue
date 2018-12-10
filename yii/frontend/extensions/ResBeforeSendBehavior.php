<?php
namespace frontend\extensions;

use Yii;
use yii\web\Response;
use yii\base\Behavior;

class ResBeforeSendBehavior extends Behavior{

    public $defaultCode = 500;

    public $defaultMsg = 'error';

    public function events() {
        return [Response::EVENT_BEFORE_SEND => 'beforeSend',];
    }

    public function beforeSend($event)
    {
        try {
            $response = $event->sender;
            if($response->data === null)$response->data = ['code'  => $this->defaultCode, 'msg'   => $this->defaultMsg,];
             elseif(!$response->isSuccessful) {
                $exception = Yii::$app->getErrorHandler()->exception;
                if(is_object($exception) && !$exception instanceof yii\web\HttpException) throw $exception;
                 else {
                    $rData = $response->data;
                    $response->data = ['code'  => empty($rData['status']) ? $this->defaultCode : $rData['status'], 'msg'   => empty($rData['message']) ? $this->defaultMsg : $rData['message'],];
                }
            } else {
                $rData = $response->data;
                $response->data = ['code' => isset($rData['error_code']) ? $rData['error_code'] : 0, 'msg' => isset($rData['res_msg']) ? $rData['res_msg'] : $rData,];
                $response->statusCode = 200;
            }
        } catch (\Exception $e) {
            $response->data = ['code'  => $this->defaultCode, 'msg'   => $this->defaultMsg,];
        }
        return true;
    }
}

