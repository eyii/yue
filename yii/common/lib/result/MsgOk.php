<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-12
 * Time: 上午10:47
 */

namespace common\lib\result;


class MsgOk extends MsgBase
{
    public $code=200;
    public $msg='操作成功';
    public $data=array();


}