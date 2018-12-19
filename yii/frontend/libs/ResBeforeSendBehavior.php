<?php
namespace frontend\libs;

use common\lib\rest\httpStatus;
use common\lib\rest\Response;
use common\lib\result\MsgBase;
use common\lib\result\MsgOk;
use Yii;

use yii\base\Behavior;

class ResBeforeSendBehavior extends Behavior{

    public $code = 500;

    public $msg = 'error';
    public $response;
    public $data;
    public function events() {
        return [Response::EVENT_BEFORE_SEND => 'beforeSend',];
    }

    public function beforeSend($event)
    {
        try {

            $this->response= $response = & $event->sender;
            $response->format = Response::FORMAT_JSON;

            if(isset($response->data)&&$response->data === null)$this->dataNull();
             elseif(!$response->isSuccessful) $this->responseAbort();
             $this->isArrayListNoCode();
             $this->isObjectNoCode();


        } catch (\Exception $e) {
          $this->exception();
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
        $response->data = ['code'  => empty($data['status']) ? $this->code : $data['status'], 'msg'   => empty($data['message']) ? $this->msg : $data['message'],];

    }
    function exception(){
        $response=&$this->response;
        $response->data = new MsgBase( $this->msg, $this->code);
    }
    function dataNull(){
        $response=&$this->response;
      if (isset($response->statusText)) $this->msg= $response->statusText;
        if($response->data === null)$response->data =new MsgOk($this->msg, httpStatus::OK,$response->data);

    }

    function isArrayListNoCode(){
        $response=&$this->response;
       if (!is_array($response->data) )return;
       if (isset($response->data['code']))return;
       if (empty($response->data))  return;
        $response->data =  new MsgOk(null, httpStatus::OK,$response->data);







    }
    function  isObjectNoCode(){
        $response=&$this->response;
        if (!is_object($response->data))return;
        if (isset($response->data->code))return;
        if (empty($response->data))  return;
        $response->data->code=httpStatus::OK;
        $response->data->data=$response->data;

    }

}

