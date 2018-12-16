<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace yii\filters;

use Yii;
use yii\base\ActionFilter;
use yii\web\BadRequestHttpException;
use yii\web\Request;


class AjaxFilter extends ActionFilter
{

    public $errorMessage = 'Request must be XMLHttpRequest.';

    public $request;



    public function init()
    {
        if ($this->request === null) $this->request = Yii::$app->getRequest();

    }

    public function beforeAction($action)
    {
        if ($this->request->getIsAjax()) return true;

        throw new BadRequestHttpException($this->errorMessage);
    }
}
