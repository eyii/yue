<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace yii\filters;

use Closure;
use yii\base\Action;
use yii\base\Component;
use yii\base\Controller;
use yii\base\InvalidConfigException;
use yii\helpers\StringHelper;
use yii\web\Request;
use yii\web\User;

class AccessRule extends Component
{

    public $allow;

    public $actions;

    public $controllers;

    public $roles;

    public $permissions;

    public $roleParams = [];

    public $ips;

    public $verbs;

    public $matchCallback;

    public $denyCallback;



    public function allows($action, $user, $request)
    {
        if ($this->matchAction($action)
            && $this->matchRole($user)
            && $this->matchIP($request->getUserIP())
            && $this->matchVerb($request->getMethod())
            && $this->matchController($action->controller)
            && $this->matchCustom($action)
        ) return $this->allow ? true : false;


        return null;
    }

    protected function matchAction($action)
    {
        return empty($this->actions) || in_array($action->id, $this->actions, true);
    }


    protected function matchController($controller)
    {
        if (empty($this->controllers)) return true;


        $id = $controller->getUniqueId();
        foreach ($this->controllers as $pattern) if (StringHelper::matchWildcard($pattern, $id)) return true;



        return false;
    }


    protected function matchRole($user)
    {
        $items = empty($this->roles) ? [] : $this->roles;

        if (!empty($this->permissions)) $items = array_merge($items, $this->permissions);


        if (empty($items)) return true;


        if ($user === false) {
            throw new InvalidConfigException('The user application component must be available to specify roles in AccessRule.');
        }

        foreach ($items as $item) {
            if ($item === '?') if ($user->getIsGuest()) return true;

             elseif ($item === '@') {
                if (!$user->getIsGuest()) return true;

            } else {
                if (!isset($roleParams)) $roleParams = $this->roleParams instanceof Closure ? call_user_func($this->roleParams, $this) : $this->roleParams;

                if ($user->can($item, $roleParams)) return true;

            }
        }

        return false;
    }


    protected function matchIP($ip)
    {
        if (empty($this->ips)) return true;

        foreach ($this->ips as $rule) {
            if ($rule === '*' || $rule === $ip || ($ip !== null && ($pos = strpos($rule, '*')) !== false && strncmp($ip, $rule, $pos) === 0)) {
                return true;
            }
        }

        return false;
    }


    protected function matchVerb($verb){
        return empty($this->verbs) || in_array(strtoupper($verb), array_map('strtoupper', $this->verbs), true);
    }

    protected function matchCustom($action){
        return empty($this->matchCallback) || call_user_func($this->matchCallback, $this, $action);
    }
}
