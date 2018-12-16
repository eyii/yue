<?php


namespace common\lib\rest;

use Yii;
use yii\base\Model;
use yii\db\ActiveRecord;
use yii\web\ServerErrorHttpException;

class UpdateAction extends Action{

    public $scenario = Model::SCENARIO_DEFAULT;



    public function run($id)
    {
        /* @var $model ActiveRecord */
        $model = $this->findModel($id);

        if ($this->checkAccess) call_user_func($this->checkAccess, $this->id, $model);


        $model->scenario = $this->scenario;
        $model->load(Yii::$app->getRequest()->getBodyParams(), '');
        if ($model->save() === false && !$model->hasErrors()) throw new ServerErrorHttpException('Failed to update the object for unknown reason.');


        return $model;
    }
}
