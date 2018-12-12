<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-12
 * Time: 上午10:52
 */

namespace common\lib\result;


class MsgBase
{
    public $code=200;
    public $msg='操作成功';
    public $data=array();
    function __construct($msg=null,$code=null,$data=array()){
          $this->data = $data;
        if ($code!=null)  $this->code = $code;

        if ($msg!=null) $this->msg = $msg;
    }
}