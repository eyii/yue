<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-10
 * Time: 下午6:45
 */

namespace frontend\modules\v1\controllers;


use common\lib\rest\httpStatus;
use common\lib\result\MsgAbort;
use common\lib\result\MsgOk;

use frontend\models\LoginForm;
use frontend\models\SignupForm;
use frontend\models\User;
use Yii;
use yii\rest\ActiveController;

class UserController extends ActiveController
{
    public $modelClass = 'frontend\models\User';


     function actionReg(){
        $model = new SignupForm();
      return  ( $id=$model->signup()) ? new MsgOk('注册成功',200,$id) : new MsgAbort('注册失败',-1,$model->getErrors() );

    }












     function actionUpdate($id){
        $model =User::findOne($id);
        return $model->load(Yii::$app->request->post(),'') && $model->save() ? new MsgOk('更新成功',200,$model->id) : new MsgOk('更新失败',-1,null);

    }


    public function actionDelete($id)
    {
        $model = User::findOne($id);
        $model->delete();
        return $this->redirect(['index']);
    }



    public function actionIndex()
    {
        if(Yii::$app->user->isGuest) $data=array('code'=>100, 'message'=>'用户未登录', 'data'=>'',);
        else{
            $data=array(
                'code'=>200,
                'message'=>'用户已经登录',
                'data'=>array('user_id'=>Yii::$app->user->id, 'user_name'=>isset(\Yii::$app->user->identity->username) ? \Yii::$app->user->identity->username : '',),);
        }
        echo json_encode($data);exit;
    }













    public function behaviors()
    {
        $behaviors = parent::behaviors();
        return $behaviors;
    }

    protected function verbs()
    {
        $verbs = parent::verbs();
        return $verbs;
    }

     function actionLogin(){

        $model = new LoginForm();
        $load= $model->load([$model->formName() => yii::$app->request->post()]);
         $rs = $model->login();
       return  $rs? new MsgOk('登录成功',httpStatus::OK,$model->getUser()):new MsgAbort(httpStatus::$code[801],httpStatus::c801,$model->getErrors());
    }


     function actionLogout(){
      $result=   Yii::$app->user->logout();
     return $result?new MsgOk('注销成功'):new MsgAbort('注销失败');
    }

    function actionLoginToken($token='')
    {
      //  yii::$app->user->loginByAccessToken($token);
   }

}