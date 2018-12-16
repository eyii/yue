<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace common\lib\rest;

use yii\base\InvalidConfigException;
use yii\base\Model;
use yii\web\ForbiddenHttpException;


class ActiveController extends \yii\rest\ActiveController
{

    public $modelClass;

    public $updateScenario = Model::SCENARIO_DEFAULT;

    public $createScenario = Model::SCENARIO_DEFAULT;


    public function init()
    {
        parent::init();
        if ($this->modelClass === null) throw new InvalidConfigException('The "modelClass" property must be set.');

    }

    public function actions()
    {
        return [
            'index' => ['class' => 'yii\rest\IndexAction', 'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'],],
            'view' => ['class' => 'yii\rest\ViewAction', 'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'],],
            'create' => ['class' => 'yii\rest\CreateAction', 'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'], 'scenario' => $this->createScenario,],
            'update' => ['class' => 'yii\rest\UpdateAction', 'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'], 'scenario' => $this->updateScenario,],
            'delete' => ['class' => 'yii\rest\DeleteAction', 'modelClass' => $this->modelClass, 'checkAccess' => [$this, 'checkAccess'],],
            'options' => ['class' => 'yii\rest\OptionsAction',],
        ];
    }

    /**
     * {@inheritdoc}
     */
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
        xdebug_break();

        return true;
     }
}
