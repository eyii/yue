<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace common\lib\rbac;


use yii\filters\auth\AuthMethod;

class HttpHeaderAuth extends AuthMethod
{
    /**
     * @var string the HTTP header name
     */
    public $header = 'X-Api-Key';
    /**
     * @var string a pattern to use to extract the HTTP authentication value
     */
    public $pattern;


    /**
     * {@inheritdoc}
     */
    public function authenticate($user, $request, $response)
    {
        $authHeader = $request->getHeaders()->get($this->header);

        if ($authHeader === null) return null;
            if ($this->pattern !== null) {
                if (preg_match($this->pattern, $authHeader, $matches)) $authHeader = $matches[1];
                else return null;

            }

            $identity = $user->loginByAccessToken($authHeader, get_class($this));
            if ($identity === null) {
                $this->challenge($response);
                $this->handleFailure($response);
            }

            return $identity;



    }
}
