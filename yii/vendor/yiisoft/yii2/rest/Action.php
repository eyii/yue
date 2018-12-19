<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace yii\rest;

use Yii;
use yii\base\InvalidConfigException;
use yii\db\ActiveRecordInterface;
use yii\web\NotFoundHttpException;


class Action extends \yii\base\Action
{

    public $modelClass;

    public $findModel;

    public $checkAccess;


    /**
     * {@inheritdoc}
     */
    public function init()
    {
        if ($this->modelClass === null) throw new InvalidConfigException(get_class($this) . '::$modelClass must be set.');

    }

    function findModel($id){
        if ($this->findModel !== null) return call_user_func($this->findModel, $id, $this);


        /* @var $modelClass ActiveRecordInterface */
        $modelClass = $this->modelClass;
        $keys = $modelClass::primaryKey();
        if (count($keys) > 1) {
            $values = explode(',', $id);
            if (count($keys) === count($values)) $model = $modelClass::findOne(array_combine($keys, $values));

        } elseif ($id !== null) $model = $modelClass::findOne($id);


        if (isset($model)) return $model;


        throw new NotFoundHttpException("Object not found: $id");
    }
}
