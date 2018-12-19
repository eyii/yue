<?php


namespace frontend\modules\v1\controllers;


use common\controllers\ActiveController;
use common\lib\result\MsgAbort;
use common\lib\result\MsgOk;
use common\models\UploadForm;

use PhpOffice\PhpSpreadsheet\IOFactory;


use Yii;


class UploadController extends ActiveController
{
    public $modelClass = 'common\models\Goods';



     function actionUpload(){

         $model = new UploadForm();
        if (!Yii::$app->request->isPost)                         return  new MsgAbort('非法访问',-20);
         if (!$model->fileIsNull())    {
             $model->getFilePath($fileName);
            $isSave=   $model->file->saveAs($fileName);
         }else $model->getFilePath($fileName);



         $result=  $this->actionRead($fileName);
         return !empty($result)?  new MsgOk("上传成功",200,$result):new MsgAbort('保存文件失败');

    }


    function actionRead($fileName =  'uploads/data.xls',$type= 'Xls'){

        $reader = IOFactory::createReader($type);
        $reader->setReadDataOnly(true);
        $spreadsheet = $reader->load($fileName);
        $data = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
        if (!is_array($data))return false;
        return $data;
    }
}