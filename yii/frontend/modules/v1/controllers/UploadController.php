<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-11
 * Time: 上午11:55
 */

namespace frontend\modules\v1\controllers;


use common\controllers\ActiveController;
use common\models\UploadForm;
use SebastianBergmann\CodeCoverage\Util;
use Yii;
use yii\web\UploadedFile;

class UploadController extends ActiveController
{
    public $modelClass = 'common\models\Goods';

    function actionSearch(){

        $model = new UploadForm();

        if (Yii::$app->request->isPost) return false;

            $model->single = UploadedFile::getInstance($model, 'single');
            $model->upload();


            $model->multiple = UploadedFile::getInstances($model, 'multiple');
            $model->uploadMultiple();

            unset($model->single,$model->multiple);


            $model->single = UploadedFile::getInstanceByName('single-file');
            $model->upload();

            //获取多个文件用 getInstancesByName
            $model->multiple = UploadedFile::getInstancesByName('multi-file');
            $model->uploadMultiple();

            unset($model->single,$model->multiple);

        return $this->render('upload', ['model' => $model]);


    }

     function actionUpload(){
      $model = new UploadForm();
     //   if (!Yii::$app->request->isPost)   return ['code'    => 20, 'msg'=> '非法访问',];
         $model->file = UploadedFile::getInstance($model, 'file');
         if ($model->file && $model->validate())
         {
             $model->file->saveAs('uploads/' . $model->file->baseName . '.' . $model->file->extension);
         }


        // return $this->render('upload', ['model' => $model]);

   /* xdebug_break();
        $request= Yii::$app->request;
         return ['code'    => 20, 'msg'=> '保存成功',];*/
    }


}