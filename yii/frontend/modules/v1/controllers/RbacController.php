<?php


namespace frontend\modules\v1\controllers;


use common\controllers\ActiveController;
use common\lib\result\MsgAbort;
use common\lib\result\MsgOk;
use common\models\UploadForm;

use PhpOffice\PhpSpreadsheet\IOFactory;


use Yii;


class RbacController extends ActiveController
{
    public $modelClass = 'common\models\Goods';



     function actionAddRole(){
         $auth = \Yii::$app->authManager;
         $author = $auth->createRole('author');
         $auth->add($author);
         $reader = $auth->createRole('reader');
         $auth->add($reader);
         $editor = $auth->createRole('editor');
         $auth->add($editor);
    }

    function actionDelRole(){
        $auth = \Yii::$app->authManager;
        $editor = $auth->createRole('editor');
        $auth->remove($editor);
    }

    function actionAuthRole(){
        $auth = \Yii::$app->authManager;
        $postAdd = $auth->createPermission('postAdd');
        $postAdd->description = '文章添加';
        $auth->add($postAdd);
        $postDelete = $auth->createPermission('postDelete');
        $postDelete->description = '文章删除';
        $auth->add($postDelete);
        $postUpdate = $auth->createPermission('postUpdate');
        $postUpdate->description = '文章编辑';
        $auth->add($postUpdate);
        $postSelect = $auth->createPermission('postSelect');
        $postSelect->description = '文章查看';
        $auth->add($postSelect);

        // 增加角色
        $author = $auth->createRole('author');
        $auth->add($author);
        $reader = $auth->createRole('reader');
        $auth->add($reader);
        $editor = $auth->createRole('editor');
        $auth->add($editor);


        // 为角色赋予权限
        $auth->addChild($author, $postAdd);// 作者 添加文章
        $auth->addChild($author, $postUpdate);// 作者 编辑文章
        $auth->addChild($reader, $postSelect);// 读者 看文章
        $auth->addChild($editor, $postDelete);
        $auth->addChild($editor, $postSelect);
        $auth->addChild($editor, $author);
        $auth->addChild($editor, $reader);

        // 为用户分配角色
        $auth->assign($author, 2);
        $auth->assign($reader, 2);
        $auth->assign($reader, 3);
        $auth->assign($reader, 4);
        $auth->assign($editor, 5);

    }
}