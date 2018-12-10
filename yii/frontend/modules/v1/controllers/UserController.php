<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-10
 * Time: 下午6:45
 */

namespace frontend\modules\v1\controllers;


use yii\rest\ActiveController;

class UserController extends ActiveController
{
    public $modelClass = 'frontend\models\User';
}