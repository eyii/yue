<?php


namespace common\lib\filters;

use Yii;

use yii\base\ActionFilter;
use yii\di\Instance;
use yii\filters\AccessRule;
use yii\web\ForbiddenHttpException;
use yii\web\User;


class AccessControl extends ActionFilter
{

    public $user = 'user';

    public $denyCallback;

    public $ruleConfig = ['class' => 'yii\filters\AccessRule'];

    public $rules = [];



     function init(){
        parent::init();
        if ($this->user !== false) $this->user = Instance::ensure($this->user, User::className());

        foreach ($this->rules as $i => $rule) if (is_array($rule)) $this->rules[$i] = Yii::createObject(array_merge($this->ruleConfig, $rule));

    }


     function beforeAction($action){
        $user = $this->user;
        $request = Yii::$app->getRequest();
        /* @var $rule AccessRule */
        foreach ($this->rules as $rule) {
            if ($allow = $rule->allows($action, $user, $request)) return true;
             elseif ($allow === false) {
                if (isset($rule->denyCallback))              call_user_func($rule->denyCallback, $rule, $action);
                elseif ($this->denyCallback !== null)       call_user_func($this->denyCallback, $rule, $action);
                else                                       $this->denyAccess($user);
                return false;
            }
        }
        if ($this->denyCallback !== null) call_user_func($this->denyCallback, null, $action);
         else $this->denyAccess($user);


        return false;
    }


    protected function denyAccess($user){
        if ($user !== false && $user->getIsGuest()) $user->loginRequired();
         else throw new ForbiddenHttpException(Yii::t('yii', 'You are not allowed to perform this action.'));
    }
}
