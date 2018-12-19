<?php


namespace common\lib\rest;

use Yii;
use yii\data\ActiveDataProvider;
use yii\data\DataFilter;


class IndexAction extends Action
{

    public $prepareDataProvider;

    public $dataFilter;



    public function run()
    {
        if ($this->checkAccess) call_user_func($this->checkAccess, $this->id);
        return $this->prepareDataProvider();
    }


    protected function prepareDataProvider()
    {
        $requestParams = Yii::$app->getRequest()->getBodyParams();
        if (empty($requestParams)) $requestParams = Yii::$app->getRequest()->getQueryParams();


        $filter = null;
        if ($this->dataFilter !== null) {
            $this->dataFilter = Yii::createObject($this->dataFilter);
            if ($this->dataFilter->load($requestParams)) {
                $filter = $this->dataFilter->build();
                if ($filter === false) return $this->dataFilter;

            }
        }

        if ($this->prepareDataProvider !== null) return call_user_func($this->prepareDataProvider, $this, $filter);


        /* @var $modelClass \yii\db\BaseActiveRecord */
        $modelClass = $this->modelClass;

        $query = $modelClass::find();
        if (!empty($filter)) $query->andWhere($filter);

        $ActiveDataProvider=Yii::createObject([
            'class' => ActiveDataProvider::className(),
            'query' => $query,
            'pagination' => ['params' => $requestParams,],
            'sort' => ['params' => $requestParams,],
        ]);
        return $ActiveDataProvider;
    }
}
