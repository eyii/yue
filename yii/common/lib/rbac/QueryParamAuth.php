<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-18
 * Time: 下午12:54
 */

namespace common\lib\rbac;


use yii\filters\auth\AuthMethod;

class QueryParamAuth extends AuthMethod{
    /**
     * @var string the parameter name for passing the access token
     */
    public $tokenParam = 'access-token';

 function authenticate($user, $request, $response){
    $accessToken = $request->get($this->tokenParam);
    if (is_string($accessToken)) {
        $identity = $user->loginByAccessToken($accessToken, get_class($this));
        if ($identity !== null) return $identity;

    }
   $accessToken !== null&& $this->handleFailure($response);


    return null;
}


}