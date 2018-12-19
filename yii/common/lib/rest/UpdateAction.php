<?php


namespace common\lib\rest;

use common\lib\result\MsgAbort;
use common\lib\result\MsgOk;
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
        $post=Yii::$app->getRequest()->getBodyParams();

        if (!$model->load($post,'body'))return new MsgAbort('载入失败',httpStatus::c802,$model->getErrors());
        if (!$model->validate())return new MsgAbort('参数不对',httpStatus::c802,$model->getErrors());
        $result= $model->save();
       return ($result)?new MsgOk('更新成功',httpStatus::OK,$model):new MsgAbort('更新失败',httpStatus::c803,$model->getErrors());



    }
}
