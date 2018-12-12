<?php
namespace common\lib\rabbitmq;
use yii\base\BaseObject;

/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-12
 * Time: 下午8:57
 */

class DownloadJob extends BaseObject implements \yii\queue\JobInterface
{
    public $url;
    public $file;

    public function execute($queue)
    {
        file_put_contents($this->file, file_get_contents($this->url));
    }
}