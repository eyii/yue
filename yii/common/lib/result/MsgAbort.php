<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-12
 * Time: 上午10:47
 */

namespace common\lib\result;


class MsgAbort extends MsgBase
{
    public $code=-1;
    public $msg='操作失败';
    public $data=array();
}