<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-12
 * Time: 下午8:47
 */

class RabbitMq_Base{
    public function __construct(){
        include_once('RabbitMq_Server.php');
    }
    public static function setRabbitMq($message,$k_route = 'operate-log',$e_name=''){
        $rabbitObj = new RabbitMq_Server();
        $rabbitObj->setRabbit($message,$k_route);//设置列队
    }
    public static function getRabbitMq($k_route = 'operate-log' ){
        $rabbitObj = new RabbitMq_Server();
        $getRabObj = $rabbitObj->getRabbit($k_route,'q_'.$k_route);//获取列队
        return $getRabObj;
    }
}
