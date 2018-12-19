#入口
 yii\base\Application::run
  yii\web\Application
                          list($route, $params)=$request->resolve();
 yii\base\Module::runAction
                          createController
 yii\base\Controller::runAction  
                          createAction
                          $module->beforeAction($action)
                          runWithParams
                         yii\base\Module\afterAction
    
    
    

  
  
#初始化配置
yii\base::__construct
        
        yii\base
        
        
框架RESTful API教程（二） - 格式化响应，授权认证和速率限制
http://www.cnblogs.com/luyucheng/p/6048274.html

yii\web\Application::handleRequest
yii\base\Module::runAction
yii\base\Controller::runAction
         runWithParams
yii\base\InlineAction::runWithParams








