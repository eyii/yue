<?php
namespace frontend\modules\v1\controllers;

use yii\rest\ActiveController;

class GoodsController extends ActiveController
{
    public $modelClass = 'common\models\Goods';

     function actionSearch(){
        return ['error_code'    => 20, 'msg'=> 'ok',];
    }
}

