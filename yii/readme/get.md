#$this->get('formatter');流程
yii2/base/Module::get
  优先从$this->_components 没则从$this->_definitions[$id]取出来建对象再存入
  
  