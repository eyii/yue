<?php


class RabbitMq_Server{
    private $conn_args = array('host'=>'127.0.0.1','port'=>'5672','login'=>'guest','password'=>'guest','vhost'=>'/');
    private $channel;
    private $e_name = 'glitzcloud';

    public function __construct(){
        //创建Exchannel
        $this->channel = $this->connrabbit($this->conn_args);
        if(!$this->channel){
            echo 'Cannot Connect to the broker';
            exit();
        }
    }

    /*
     *创建RabbitMq Message
     */
    public function setRabbit($message,$k_route,$e_name=''){
        if(empty($e_name)){
            $e_name = $this->e_name;
        }
        $channel = $this->channel;
        $ex = new AMQPExchange($channel);
        $ex->setName($e_name);//创建名字
        $ex->setType(AMQP_EX_TYPE_DIRECT); //direct类型
        $ex->setFlags(AMQP_DURABLE); //持久化
        $ex->declareExchange();
        $ex->publish($message,$k_route);
    }

    /*
     *获取RabbitMq Message
     */
    public function getRabbit($k_route,$q_name){
        $channel = $this->channel;
        $q = new AMQPQueue($channel);
        $q->setName($q_name);
        $q->setFlags(AMQP_DURABLE);
        $q->declare();
        $q->bind($this->e_name, $k_route);
        $messages = $q->get(AMQP_AUTOACK);
        if(is_object( $messages))
            return $messages->getBody();
        return $messages;
    }

    /**
     *链接RabbitMQ
     */
    protected function connrabbit($conn_args){
        $conn = new AMQPConnection($conn_args);
        if(!$conn->connect()){
            return false;
        }
        $channel = new AMQPChannel($conn);
        return $channel;
    }
}
