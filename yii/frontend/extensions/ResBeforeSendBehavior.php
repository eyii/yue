<?php
namespace frontend\extensions;

use Yii;
use yii\web\Response;
use yii\base\Behavior;

class ResBeforeSendBehavior extends Behavior{

    public $defaultCode = 500;

    public $defaultMsg = 'error';
    public $response;
    public function events() {
        return [Response::EVENT_BEFORE_SEND => 'beforeSend',];
    }

    public function beforeSend($event)
    {
        try {
            $this->response= $response = & $event->sender;
            if($response->data === null)$response->data = ['code'  => $this->defaultCode, 'msg'   => $this->defaultMsg,];
             elseif(!$response->isSuccessful) $this->responseAbort();


        } catch (\Exception $e) {
            $response->data = ['code'  => $this->defaultCode, 'msg'   => $this->defaultMsg,];
        }
        return true;
    }
    function responseOk(){
        $response=&$this->response;
        $data = $response->data;
    //    $response->data = ['code' => isset($data->code) ?$data->code: 0, 'msg' => isset($data->msg) ?$data->msg : $data];
      //  $response->statusCode = 200;
    }
    function responseAbort(){
        $response=&$this->response;
        $exception = Yii::$app->getErrorHandler()->exception;
        if(is_object($exception) && !$exception instanceof yii\web\HttpException) throw $exception;
        $data = $response->data;
        $response->data = ['code'  => empty($data['status']) ? $this->defaultCode : $data['status'], 'msg'   => empty($data['message']) ? $this->defaultMsg : $data['message'],];

    }
    function dataNull(){
        $response=&$this->response;
        if($response->data === null)$response->data = ['code'  => $this->defaultCode, 'msg'   => $this->defaultMsg,];

    }
}

