<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-18
 * Time: 下午4:39
 */

namespace common\lib\rbac;


class HttpBearerAuth  extends \yii\filters\auth\HttpBearerAuth
{
    public $header = 'Authorization';

    public $pattern = '/^Bearer\s+(.*?)$/';

    public $realm = 'api';



     function challenge($response){
        $response->getHeaders()->set('WWW-Authenticate', "Bearer realm=\"{$this->realm}\"");
    }
}