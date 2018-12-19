<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace common\lib\rest;






use yii\base\InvalidConfigException;
use yii\base\Model;



class ActiveController extends \yii\rest\ActiveController
{


    public $modelClass;

    public $updateScenario = Model::SCENARIO_DEFAULT;

    public $createScenario = Model::SCENARIO_DEFAULT;



    function init(){
        parent::init();
        if ($this->modelClass === null) throw new InvalidConfigException('The "modelClass" property must be set.');

    }

    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'index' =>   ['class' => 'common\lib\rest\IndexAction', 'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'],],
            'view' =>    ['class' => 'common\lib\rest\ViewAction',         'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'],],
            'create' =>  ['class' => 'common\lib\rest\CreateAction',       'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'], 'scenario' => $this->createScenario,],
            'update' =>  ['class' => 'common\lib\rest\UpdateAction',       'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'], 'scenario' => $this->updateScenario,],
            'delete' =>  ['class' => 'common\lib\rest\DeleteAction',       'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'],],
            'options' => ['class' => 'common\lib\rest\OptionsAction',],
        ];
    }


    protected function verbs()
    {
        return [
            'index' => ['GET', 'HEAD'],
            'view' => ['GET', 'HEAD'],
            'create' => ['POST'],
            'update' => ['PUT', 'PATCH'],
            'delete' => ['DELETE'],
        ];
    }

    function checkAccess($action, $model = null, $params = []){
        return false;
    }

    /*  public function behaviors()
      {
          return [
              'access' => [
                  'class' => AccessControl::className(),
                //  'only' => ['login', 'logout', 'signup'],
                  'rules' => [
                      ['allow' => true, 'actions' => ['login', 'signup'], 'roles' => ['?'],],
                      ['allow' => true, 'actions' => ['logout'], 'roles' => ['@'],],
                  ],
                  'denyCallback' => function ($rule, $action) {
                   return   new MsgAbort(httpStatus::c401,httpStatus::$code['401']);
                   //   throw new \Exception('You are not allowed to access this page');
                  }
              ],
          ];
      }*/
}