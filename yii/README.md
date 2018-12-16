#入口
 yii\base\Application::run
 yii\base\Module::runAction
 yii\base\Controller::runAction  
    runWithParams
    
    
    
#$this->get('formatter');流程
yii2/base/Module::get
     !isset($this->module) {
       $this->_components
        isset($this->_definitions[$id] 是对象存入 $this->_components[$id] = $definition;
        不是调用 Yii::createObject($definition);建后存入 $this->_components
     }