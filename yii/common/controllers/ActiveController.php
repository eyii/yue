<?php
namespace common\controllers;

use yii\base\InvalidConfigException;
use yii\base\Model;
use yii\filters\AccessControl;
use yii\filters\Cors;
use yii\helpers\ArrayHelper;
use yii\web\ForbiddenHttpException;

class ActiveController extends \yii\rest\ActiveController
{

    public $modelClass;

    public $updateScenario = Model::SCENARIO_DEFAULT;
    /**
     * @var string the scenario used for creating a model.
     * @see \yii\base\Model::scenarios()
     */
    public $createScenario = Model::SCENARIO_DEFAULT;



    public function init()
    {
        parent::init();
        if ($this->modelClass === null) {
            throw new InvalidConfigException('The "modelClass" property must be set.');
        }
    }


    public function actions()
    {
        return [
            'index' => [
                'class' => 'yii\rest\IndexAction',
                'modelClass' => $this->modelClass,
                'checkAccess' => [$this, 'checkAccess'],
            ],
            'view' => [
                'class' => 'yii\rest\ViewAction',
                'modelClass' => $this->modelClass,
                'checkAccess' => [$this, 'checkAccess'],
            ],
            'create' => [
                'class' => 'yii\rest\CreateAction',
                'modelClass' => $this->modelClass,
                'checkAccess' => [$this, 'checkAccess'],
                'scenario' => $this->createScenario,
            ],
            'update' => [
                'class' => 'yii\rest\UpdateAction',
                'modelClass' => $this->modelClass,
                'checkAccess' => [$this, 'checkAccess'],
                'scenario' => $this->updateScenario,
            ],
            'delete' => [
                'class' => 'yii\rest\DeleteAction',
                'modelClass' => $this->modelClass,
                'checkAccess' => [$this, 'checkAccess'],
            ],
            'options' => [
                'class' => 'yii\rest\OptionsAction',
            ],
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
    }

    public function behaviors()
    {
      $behaviors=  parent::behaviors();
       $ip= ['access' => ['class' => AccessControl::className(),
                       'only' => ['login', 'logout', 'signup'],
                       'rules' => [['ips' => [ '127.0.0.1'], 'allow' => false,],],
              ]];
     $cors=[['class' => Cors::className(),
                    'cors' => [
                        'Origin' => ['*'],
                        'Access-Control-Request-Method' => [], //POST
                        'Access-Control-Request-Headers'=>['*'] //content-type
                    ],

            ],
        ];
       $behaviors=  ArrayHelper::merge($cors, $behaviors);
        $behaviors=  ArrayHelper::merge($ip, $behaviors);
        return $behaviors;
    }

}