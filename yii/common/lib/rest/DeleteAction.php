<?php
namespace common\lib\rest;
use common\lib\result\MsgAbort;
use common\lib\result\MsgOk;
use Yii;
use yii\db\ActiveRecord;


class DeleteAction extends Action
{
     function run($id){
         /* @var $model ActiveRecord */
        $model = $this->findModel($id);
        if ($this->checkAccess) call_user_func($this->checkAccess, $this->id, $model);
     return $model->delete() === false? new MsgAbort('删除失败',httpStatus::c804,$model->getErrors()):new MsgOk('更新成功',httpStatus::OK,$id);
    }
}
