<?php


namespace yii\rbac;

use yii\base\BaseObject;

abstract class Rule extends BaseObject
{

    public $name;

    public $createdAt;

    public $updatedAt;

    abstract public function execute($user, $item, $params);
}
