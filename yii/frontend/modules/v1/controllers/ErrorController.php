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
use yii\log\Target;
use yii\web\UploadedFile;

class ErrorController extends ActiveController
{

    public function actionError(){
            xdebug_break();
        $error = Yii::$app->errorHandler->exception;
        if($error){

            $file = $error->getFile();
            $line = $error->getLine();
            $message = $error->getMessage();
            $code = $error->getCode();





 }

}