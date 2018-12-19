<?php


namespace common\lib\rest;

use Yii;


class OptionsAction extends \yii\base\Action{

    public $collectionOptions = ['GET', 'POST', 'HEAD', 'OPTIONS'];

    public $resourceOptions = ['GET', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS'];


     function run($id = null){
       Yii::$app->getRequest()->getMethod() !== 'OPTIONS' && Yii::$app->getResponse()->setStatusCode(405);

        $options = $id === null ? $this->collectionOptions : $this->resourceOptions;
        $headers = Yii::$app->getResponse()->getHeaders();
        $headers->set('Allow', implode(', ', $options));
        $headers->set('Access-Control-Allow-Methods', implode(', ', $options));
    }
}
