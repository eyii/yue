DROP TABLE IF EXISTS `ot_auth_group_access`;


CREATE TABLE `ot_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ot_auth_rule`;

CREATE TABLE `ot_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;

INSERT INTO `ot_auth_rule` VALUES (1,'admin',2,'Admin/Index/index','首页',1,''),(2,'admin',2,'Admin/Article/index','内容',1,''),(3,'admin',2,'Admin/User/index','用户',1,''),(4,'admin',2,'Admin/Addons/index','扩展',1,''),(5,'admin',2,'Admin/Config/group','系统',1,''),(7,'admin',1,'Admin/article/add','新增',1,''),(8,'admin',1,'Admin/article/edit','编辑',1,''),(9,'admin',1,'Admin/article/setStatus','改变状态',1,''),(10,'admin',1,'Admin/article/update','保存',1,''),(11,'admin',1,'Admin/article/autoSave','保存草稿',1,''),(12,'admin',1,'Admin/article/move','移动',1,''),(13,'admin',1,'Admin/article/copy','复制',1,''),(14,'admin',1,'Admin/article/paste','粘贴',1,''),(15,'admin',1,'Admin/article/permit','还原',1,''),(16,'admin',1,'Admin/article/clear','清空',1,''),(17,'admin',1,'Admin/Article/examine','审核列表',1,''),(18,'admin',1,'Admin/article/recycle','回收站',1,''),(19,'admin',1,'Admin/User/addaction','新增用户行为',1,''),(20,'admin',1,'Admin/User/editaction','编辑用户行为',1,''),(21,'admin',1,'Admin/User/saveAction','保存用户行为',1,''),(22,'admin',1,'Admin/User/setStatus','变更行为状态',1,''),(23,'admin',1,'Admin/User/changeStatus?method=forbidUser','禁用会员',1,''),(24,'admin',1,'Admin/User/changeStatus?method=resumeUser','启用会员',1,''),(25,'admin',1,'Admin/User/changeStatus?method=deleteUser','删除会员',1,''),(26,'admin',1,'Admin/User/index','用户信息',1,''),(27,'admin',1,'Admin/User/action','用户行为',1,''),(28,'admin',1,'Admin/AuthManager/changeStatus?method=deleteGroup','删除',1,''),(29,'admin',1,'Admin/AuthManager/changeStatus?method=forbidGroup','禁用',1,''),(30,'admin',1,'Admin/AuthManager/changeStatus?method=resumeGroup','恢复',1,''),(31,'admin',1,'Admin/AuthManager/createGroup','新增',1,''),(32,'admin',1,'Admin/AuthManager/editGroup','编辑',1,''),(33,'admin',1,'Admin/AuthManager/writeGroup','保存用户组',1,''),(34,'admin',1,'Admin/AuthManager/group','授权',1,''),(35,'admin',1,'Admin/AuthManager/access','访问授权',1,''),(36,'admin',1,'Admin/AuthManager/user','成员授权',1,''),(37,'admin',1,'Admin/AuthManager/removeFromGroup','解除授权',1,''),(38,'admin',1,'Admin/AuthManager/addToGroup','保存成员授权',1,''),(39,'admin',1,'Admin/AuthManager/category','分类授权',1,''),(40,'admin',1,'Admin/AuthManager/addToCategory','保存分类授权',1,''),(41,'admin',1,'Admin/AuthManager/index','权限管理',1,''),(42,'admin',1,'Admin/Addons/create','创建',1,''),(43,'admin',1,'Admin/Addons/checkForm','检测创建',1,''),(44,'admin',1,'Admin/Addons/preview','预览',1,''),(45,'admin',1,'Admin/Addons/build','快速生成插件',1,''),(46,'admin',1,'Admin/Addons/config','设置',1,''),(47,'admin',1,'Admin/Addons/disable','禁用',1,''),(48,'admin',1,'Admin/Addons/enable','启用',1,''),(49,'admin',1,'Admin/Addons/install','安装',1,''),(50,'admin',1,'Admin/Addons/uninstall','卸载',1,''),(51,'admin',1,'Admin/Addons/saveconfig','更新配置',1,''),(52,'admin',1,'Admin/Addons/adminList','插件后台列表',1,''),(53,'admin',1,'Admin/Addons/execute','URL方式访问插件',1,''),(54,'admin',1,'Admin/Addons/index','插件管理',1,''),(55,'admin',1,'Admin/Addons/hooks','钩子管理',1,''),(56,'admin',1,'Admin/model/add','新增',1,''),(57,'admin',1,'Admin/model/edit','编辑',1,''),(58,'admin',1,'Admin/model/setStatus','改变状态',1,''),(59,'admin',1,'Admin/model/update','保存数据',1,''),(60,'admin',1,'Admin/Model/index','模型管理',1,''),(61,'admin',1,'Admin/Config/edit','编辑',1,''),(62,'admin',1,'Admin/Config/del','删除',1,''),(63,'admin',1,'Admin/Config/add','新增',1,''),(64,'admin',1,'Admin/Config/save','保存',1,''),(65,'admin',1,'Admin/Config/group','网站设置',1,''),(66,'admin',1,'Admin/Config/index','配置管理',1,''),(67,'admin',1,'Admin/Channel/add','新增',1,''),(68,'admin',1,'Admin/Channel/edit','编辑',1,''),(69,'admin',1,'Admin/Channel/del','删除',1,''),(70,'admin',1,'Admin/Channel/index','导航管理',1,''),(71,'admin',1,'Admin/Category/edit','编辑',1,''),(72,'admin',1,'Admin/Category/add','新增',1,''),(73,'admin',1,'Admin/Category/remove','删除',1,''),(74,'admin',1,'Admin/Category/index','分类管理',1,''),(75,'admin',1,'Admin/file/upload','上传控件',-1,''),(76,'admin',1,'Admin/file/uploadPicture','上传图片',-1,''),(77,'admin',1,'Admin/file/download','下载',-1,''),(94,'admin',1,'Admin/AuthManager/modelauth','模型授权',1,''),(79,'admin',1,'Admin/article/batchOperate','导入',1,''),(80,'admin',1,'Admin/Database/index?type=export','备份数据库',1,''),(81,'admin',1,'Admin/Database/index?type=import','还原数据库',1,''),(82,'admin',1,'Admin/Database/export','备份',1,''),(83,'admin',1,'Admin/Database/optimize','优化表',1,''),(84,'admin',1,'Admin/Database/repair','修复表',1,''),(86,'admin',1,'Admin/Database/import','恢复',1,''),(87,'admin',1,'Admin/Database/del','删除',1,''),(88,'admin',1,'Admin/User/add','新增用户',1,''),(89,'admin',1,'Admin/Attribute/index','属性管理',1,''),(90,'admin',1,'Admin/Attribute/add','新增',1,''),(91,'admin',1,'Admin/Attribute/edit','编辑',1,''),(92,'admin',1,'Admin/Attribute/setStatus','改变状态',1,''),(93,'admin',1,'Admin/Attribute/update','保存数据',1,''),(95,'admin',1,'Admin/AuthManager/addToModel','保存模型授权',1,''),(96,'admin',1,'Admin/Category/move','移动',-1,''),(97,'admin',1,'Admin/Category/merge','合并',-1,''),(98,'admin',1,'Admin/Config/menu','后台菜单管理',-1,''),(99,'admin',1,'Admin/Article/mydocument','内容',-1,''),(100,'admin',1,'Admin/Menu/index','菜单管理',1,''),(101,'admin',1,'Admin/other','其他',-1,''),(102,'admin',1,'Admin/Menu/add','新增',1,''),(103,'admin',1,'Admin/Menu/edit','编辑',1,''),(104,'admin',1,'Admin/Think/lists?model=article','文章管理',-1,''),(105,'admin',1,'Admin/Think/lists?model=download','下载管理',-1,''),(106,'admin',1,'Admin/Think/lists?model=config','配置管理',-1,''),(107,'admin',1,'Admin/Action/actionlog','行为日志',1,''),(108,'admin',1,'Admin/User/updatePassword','修改密码',1,''),(109,'admin',1,'Admin/User/updateNickname','修改昵称',1,''),(110,'admin',1,'Admin/action/edit','查看行为日志',1,''),(205,'admin',1,'Admin/think/add','新增数据',1,''),(111,'admin',2,'Admin/article/index','文档列表',-1,''),(112,'admin',2,'Admin/article/add','新增',-1,''),(113,'admin',2,'Admin/article/edit','编辑',-1,''),(114,'admin',2,'Admin/article/setStatus','改变状态',-1,''),(115,'admin',2,'Admin/article/update','保存',-1,''),(116,'admin',2,'Admin/article/autoSave','保存草稿',-1,''),(117,'admin',2,'Admin/article/move','移动',-1,''),(118,'admin',2,'Admin/article/copy','复制',-1,''),(119,'admin',2,'Admin/article/paste','粘贴',-1,''),(120,'admin',2,'Admin/article/batchOperate','导入',-1,''),(121,'admin',2,'Admin/article/recycle','回收站',-1,''),(122,'admin',2,'Admin/article/permit','还原',-1,''),(123,'admin',2,'Admin/article/clear','清空',-1,''),(124,'admin',2,'Admin/User/add','新增用户',-1,''),(125,'admin',2,'Admin/User/action','用户行为',-1,''),(126,'admin',2,'Admin/User/addAction','新增用户行为',-1,''),(127,'admin',2,'Admin/User/editAction','编辑用户行为',-1,''),(128,'admin',2,'Admin/User/saveAction','保存用户行为',-1,''),(129,'admin',2,'Admin/User/setStatus','变更行为状态',-1,''),(130,'admin',2,'Admin/User/changeStatus?method=forbidUser','禁用会员',-1,''),(131,'admin',2,'Admin/User/changeStatus?method=resumeUser','启用会员',-1,''),(132,'admin',2,'Admin/User/changeStatus?method=deleteUser','删除会员',-1,''),(133,'admin',2,'Admin/AuthManager/index','权限管理',-1,''),(134,'admin',2,'Admin/AuthManager/changeStatus?method=deleteGroup','删除',-1,''),(135,'admin',2,'Admin/AuthManager/changeStatus?method=forbidGroup','禁用',-1,''),(136,'admin',2,'Admin/AuthManager/changeStatus?method=resumeGroup','恢复',-1,''),(137,'admin',2,'Admin/AuthManager/createGroup','新增',-1,''),(138,'admin',2,'Admin/AuthManager/editGroup','编辑',-1,''),(139,'admin',2,'Admin/AuthManager/writeGroup','保存用户组',-1,''),(140,'admin',2,'Admin/AuthManager/group','授权',-1,''),(141,'admin',2,'Admin/AuthManager/access','访问授权',-1,''),(142,'admin',2,'Admin/AuthManager/user','成员授权',-1,''),(143,'admin',2,'Admin/AuthManager/removeFromGroup','解除授权',-1,''),(144,'admin',2,'Admin/AuthManager/addToGroup','保存成员授权',-1,''),(145,'admin',2,'Admin/AuthManager/category','分类授权',-1,''),(146,'admin',2,'Admin/AuthManager/addToCategory','保存分类授权',-1,''),(147,'admin',2,'Admin/AuthManager/modelauth','模型授权',-1,''),(148,'admin',2,'Admin/AuthManager/addToModel','保存模型授权',-1,''),(149,'admin',2,'Admin/Addons/create','创建',-1,''),(150,'admin',2,'Admin/Addons/checkForm','检测创建',-1,''),(151,'admin',2,'Admin/Addons/preview','预览',-1,''),(152,'admin',2,'Admin/Addons/build','快速生成插件',-1,''),(153,'admin',2,'Admin/Addons/config','设置',-1,''),(154,'admin',2,'Admin/Addons/disable','禁用',-1,''),(155,'admin',2,'Admin/Addons/enable','启用',-1,''),(156,'admin',2,'Admin/Addons/install','安装',-1,''),(157,'admin',2,'Admin/Addons/uninstall','卸载',-1,''),(158,'admin',2,'Admin/Addons/saveconfig','更新配置',-1,''),(159,'admin',2,'Admin/Addons/adminList','插件后台列表',-1,''),(160,'admin',2,'Admin/Addons/execute','URL方式访问插件',-1,''),(161,'admin',2,'Admin/Addons/hooks','钩子管理',-1,''),(162,'admin',2,'Admin/Model/index','模型管理',-1,''),(163,'admin',2,'Admin/model/add','新增',-1,''),(164,'admin',2,'Admin/model/edit','编辑',-1,''),(165,'admin',2,'Admin/model/setStatus','改变状态',-1,''),(166,'admin',2,'Admin/model/update','保存数据',-1,''),(167,'admin',2,'Admin/Attribute/index','属性管理',-1,''),(168,'admin',2,'Admin/Attribute/add','新增',-1,''),(169,'admin',2,'Admin/Attribute/edit','编辑',-1,''),(170,'admin',2,'Admin/Attribute/setStatus','改变状态',-1,''),(171,'admin',2,'Admin/Attribute/update','保存数据',-1,''),(172,'admin',2,'Admin/Config/index','配置管理',-1,''),(173,'admin',2,'Admin/Config/edit','编辑',-1,''),(174,'admin',2,'Admin/Config/del','删除',-1,''),(175,'admin',2,'Admin/Config/add','新增',-1,''),(176,'admin',2,'Admin/Config/save','保存',-1,''),(177,'admin',2,'Admin/Menu/index','菜单管理',-1,''),(178,'admin',2,'Admin/Channel/index','导航管理',-1,''),(179,'admin',2,'Admin/Channel/add','新增',-1,''),(180,'admin',2,'Admin/Channel/edit','编辑',-1,''),(181,'admin',2,'Admin/Channel/del','删除',-1,''),(182,'admin',2,'Admin/Category/index','分类管理',-1,''),(183,'admin',2,'Admin/Category/edit','编辑',-1,''),(184,'admin',2,'Admin/Category/add','新增',-1,''),(185,'admin',2,'Admin/Category/remove','删除',-1,''),(186,'admin',2,'Admin/Category/move','移动',-1,''),(187,'admin',2,'Admin/Category/merge','合并',-1,''),(188,'admin',2,'Admin/Database/index?type=export','备份数据库',-1,''),(189,'admin',2,'Admin/Database/export','备份',-1,''),(190,'admin',2,'Admin/Database/optimize','优化表',-1,''),(191,'admin',2,'Admin/Database/repair','修复表',-1,''),(192,'admin',2,'Admin/Database/index?type=import','还原数据库',-1,''),(193,'admin',2,'Admin/Database/import','恢复',-1,''),(194,'admin',2,'Admin/Database/del','删除',-1,''),(195,'admin',2,'Admin/other','其他',1,''),(196,'admin',2,'Admin/Menu/add','新增',-1,''),(197,'admin',2,'Admin/Menu/edit','编辑',-1,''),(198,'admin',2,'Admin/Think/lists?model=article','应用',-1,''),(199,'admin',2,'Admin/Think/lists?model=download','下载管理',-1,''),(200,'admin',2,'Admin/Think/lists?model=config','应用',-1,''),(201,'admin',2,'Admin/Action/actionlog','行为日志',-1,''),(202,'admin',2,'Admin/User/updatePassword','修改密码',-1,''),(203,'admin',2,'Admin/User/updateNickname','修改昵称',-1,''),(204,'admin',2,'Admin/action/edit','查看行为日志',-1,''),(206,'admin',1,'Admin/think/edit','编辑数据',1,''),(207,'admin',1,'Admin/Menu/import','导入',1,''),(208,'admin',1,'Admin/Model/generate','生成',1,''),(209,'admin',1,'Admin/Addons/addHook','新增钩子',1,''),(210,'admin',1,'Admin/Addons/edithook','编辑钩子',1,''),(211,'admin',1,'Admin/Article/sort','文档排序',1,''),(212,'admin',1,'Admin/Config/sort','排序',1,''),(213,'admin',1,'Admin/Menu/sort','排序',1,''),(214,'admin',1,'Admin/Channel/sort','排序',1,''),(215,'admin',1,'Admin/Category/operate/type/move','移动',1,''),(216,'admin',1,'Admin/Category/operate/type/merge','合并',1,''),(217,'admin',1,'Admin/article/index','文档列表',1,''),(218,'admin',1,'Admin/think/lists','数据列表',1,''),(219,'admin',2,'Admin/Caiji/index','采集',1,''),(220,'admin',2,'Admin/Huancun/index','缓存',1,''),(221,'admin',1,'Admin/Caiji/config','采集设置',-1,''),(222,'admin',1,'Admin/Caiji/index','采集设置',1,''),(223,'admin',1,'Admin/Caiji/jiedian','采集节点',1,''),(224,'admin',1,'Admin/Caiji/filter','过滤屏蔽',1,''),(225,'admin',1,'Admin/Caiji/replace','同义词替换',1,''),(226,'admin',1,'Admin/Caiji/linkwords','关键词内链',1,''),(227,'admin',1,'Admin/Caiji/addJiedian','新增采集节点',1,''),(228,'admin',1,'Admin/Caiji/edit','编辑采集节点',1,''),(229,'admin',1,'Admin/Huancun/index','缓存设置',1,''),(230,'admin',1,'Admin/Huancun/del','缓存删除',1,''),(231,'admin',1,'Admin/Huancun/save','缓存修改',1,''),(232,'admin',1,'Admin/Caiji/save','采集设置保存',1,''),(233,'admin',1,'Admin/Otherarc/template','模板设置',1,''),(234,'admin',1,'Admin/Otherarc/category','分类管理',1,''),(235,'admin',2,'Admin/Otherarc/index','其他文章',1,'');

DROP TABLE IF EXISTS `ot_caiji_classic`;

CREATE TABLE `ot_caiji_classic` (
  `id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '配置类型',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) DEFAULT '0' COMMENT '修改时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '配置状态',
  `sort` smallint(3) DEFAULT '0' COMMENT '配置排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `ot_caiji_config`;
CREATE TABLE `ot_caiji_config` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `group` tinyint(3) NOT NULL DEFAULT '0' COMMENT '配置分组',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `extra` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '配置选项',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置注释',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '配置状态',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;




INSERT INTO `ot_caiji_config` VALUES (1,'WEB_SITE_TITLE',1,1,'网站名称','','小偷程序测试站1','网站名称',0,1530340233,1,0),(2,'WEB_URL',1,1,'网站地址','','http://dev.xiaotou.com/','网址，如 http://www.aaa.com,以http://开头，以/结尾',0,1530340233,1,0),(3,'WEB_INDEX_TITLE',1,1,'网站首页title','','首页title','用在首页显示',0,1530340233,1,0),(4,'INDEX_KEYWORDS',1,1,'首页keywords','','keywords1,keywords2,keywords3','首页使用',0,1530340233,1,0),(5,'INDEX_DESCRIPTION',1,2,'首页description','','首页description','首页使用',0,1530340233,1,0),(6,'LINK_WORDS',2,2,'关键词内链','','百度:http://baidu.com\r\n腾讯:http://qq.com','每行一个关键词和链接，用“:”隔开\r\n如：\r\n百度:http://baidu.com\r\n腾讯:http://qq.com',1510134927,1511770769,1,2),(7,'LINKWORDS_ON',2,4,'关键词内链开关 ','0:关闭,1:开启','0','是否开启关键词内链',1510134927,1511770769,1,1),(8,'REPLACE_WORD_ON',3,4,'同义词替换开关','0:关闭,1:开启','0','是否开启同义词替换',1510135838,1512055300,1,0),(9,'REPLACE_WORD',3,2,'同义词替换','','忍耐:忍受\r\n鬼泣:鬼哭神嚎','每行一对同义词，以半角逗号:隔开\r\n如：\r\n忍耐:忍受',1510135838,1512055300,1,0),(10,'DEFAULT_RULE',5,1,'默认节点','','8','默认选择的节点',1510200867,1533297823,1,0),(11,'REPLACE_FILE',1,3,'需要替换的文件格式','','html,html,shtm,shtml,txt,jhtml','用,分开',1515575364,1530340233,1,0),(12,'SPIDER_PLAN',1,4,'爬虫方法','curl:curl方法 旧版,\r\nquerylist:querylist方法','querylist','curl和querylist',1526456217,1530340233,1,2),(13,'ACTION_MODEL',1,4,'运行模式','0:测试模式,1:缓存模式','1','运行模式，测试模式不缓存内容。配置完成后选择缓存模式',1526456391,1530340233,1,0),(14,'PROXY_ON',6,4,'使用代理','0:关闭,1:开启','0','代理设置',1526456547,1530068896,1,0),(15,'PROXY_TYPE',6,4,'代理方式','api:API,ip:普通IP方式','api','两种代理方式，一种输入代理API接口，获取动态IP，另一种是常规方式，输入IP、账户密码。',1526456547,1530068896,1,0),(16,'PROXY_API',6,1,'API接口','','','动态IP，代理接口',1526456547,1530068896,1,0),(17,'PROXY_IP',6,1,'代理IP','','','代理IP的格式 http://127.0.0.1、https://127.0.0.1:8080、http://127.0.0.1:8080@user:pass',1526456547,1530068896,1,0);

DROP TABLE IF EXISTS `ot_caiji_linkwords`;

CREATE TABLE `ot_caiji_linkwords` (
  `id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `word` varchar(30) NOT NULL DEFAULT '' COMMENT '关键词',
  `links` varchar(30) NOT NULL DEFAULT '' COMMENT '关键词指向的链接',
  `remark` varchar(100) DEFAULT '' COMMENT '说明',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;




DROP TABLE IF EXISTS `ot_caiji_replace`;

CREATE TABLE `ot_caiji_replace` (
  `id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `word` varchar(30) NOT NULL DEFAULT '' COMMENT '替换前',
  `neword` varchar(30) NOT NULL DEFAULT '' COMMENT '替换后的词',
  `remark` varchar(100) DEFAULT '' COMMENT '说明',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;





DROP TABLE IF EXISTS `ot_caiji_rule`;

CREATE TABLE `ot_caiji_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) NOT NULL COMMENT '节点名称',
  `webname` varchar(255) NOT NULL COMMENT '目标站名称',
  `weburl` varchar(255) NOT NULL COMMENT '目标站地址',
  `siftags` varchar(100) NOT NULL DEFAULT '0' COMMENT '标签过滤',
  `other_tags` char(50) NOT NULL DEFAULT '0' COMMENT '站内外过滤',
  `str_rules` text NOT NULL COMMENT '字符串替换规则',
  `reg_rules` text NOT NULL COMMENT '正则替换规则',
  `proxy_ip` varchar(255) NOT NULL COMMENT '代理IP',
  `webcharset` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '目标站编码',
  `remark` varchar(255) DEFAULT NULL COMMENT '使用说明',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `subdomain` text NOT NULL COMMENT '目标站其他二级域名',
  `forcedurl` tinyint(2) NOT NULL DEFAULT '0' COMMENT '强制转换url',
  `url_rewrite_on` char(50) NOT NULL DEFAULT '0' COMMENT 'url重写',
  `url_rewrite_rules` text NOT NULL COMMENT 'URL重写规则',
  `xpath_nav_mode` char(10) NOT NULL COMMENT '导航添加方式',
  `xpath_nav_replace` varchar(255) NOT NULL COMMENT '替换导航位置(请和新导航选择数量保持一致 用逗号分开)',
  `xpath_nav_block` varchar(255) NOT NULL COMMENT '导航块Xpath定位(单个导航的父节点)',
  `xpath_nav_template_mode` tinyint(2) NOT NULL COMMENT '单个导航模板类型',
  `xpath_nav_type_template` varchar(255) NOT NULL COMMENT '输入模板：<{name}> <{url}>分别代表导航名称和网址',
  `xpath_nav_pos_template` varchar(255) NOT NULL COMMENT 'Xpath定位单个导航模板(基于导航块)',
  `xpath_nav_clean_template` varchar(255) NOT NULL COMMENT '清理单个导航不需要的内容(基于定位的单个导航块)',
  `xpath_nav_article_category` varchar(255) NOT NULL COMMENT '添加到导航的内容分类ID(默认全部)',
  `xpath_enable` varchar(100) NOT NULL COMMENT '启用XPATH替换',
  `xpath_list_template` varchar(255) NOT NULL COMMENT '文章列表页模板',
  `xpath_list_block` varchar(255) NOT NULL COMMENT '文章列表块(文章列的父级节点)',
  `xpath_list_row_type` text NOT NULL COMMENT '文章列模板输入 标签<{title}>代表文章的标题 可用标签还有(url链接、datetime时间、desc描述) &#x3C;img/&#x3E; 等单标签 后面必须加/',
  `xpath_article_template` varchar(255) NOT NULL COMMENT '文章页模板',
  `xpath_article_fields` text NOT NULL COMMENT '文章内容定位 每行一个标签定位 格式( 标签:xpath定位) 如 title://div[@id=''content'']/h1 ',
  `xpath_list_pages` varchar(255) NOT NULL COMMENT '分页节点',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;




INSERT INTO `ot_caiji_rule` VALUES (1,'测试节点1','周公解梦','http://www.usife.com/','1,2,4,5,10,11','outjs','576O5Zu9******54Gv5aGU5Zu9','','',0,'',1,1510113551,1530011316,'http://img.17sucai.com******imgcache\r\n##########',0,'0','','1','','',1,'','','','','','','','','','',''),(2,'测试节点2','seo十万个为什么','http://www.mahaixiang.cn/','0','0','','','',1,'',0,1510136007,1530012165,'aaa.mahaixiang.cn******aaa\r\n##########',0,'0','','1','','',1,'','','','','','','','','','',''),(3,'无人机之家','无人机之家','https://www.chineseinhouston.com/','1,2,3,4','outjs','5rKz5YyX5bu65oqV******5rKz5YyX5bu66K6+5oqV6LWE\n##########\nPGRpdiBjbGFzcz0iYmFubmVyIG1fYXV0byI+DQo8IS0tPGVtYmVkIHdpZHRoPSIxMDAwIiBoZWlnaHQ9IjI4NCIgaWQ9InVuZGVmaW5lZCIgcGx1Z3NwYWNlPSJodHRwOi8vd3d3Lm1hY3JvbWVkaWEuY29tL3Nob2Nrd2F2ZS9kb3dubG9hZC9pbmRleC5jZ2k/UDFfUHJvZF9WZXJzaW9uPVNob2Nrd2F2ZUZsYXNoIiB0eXBlPSJhcHBsaWNhdGlvbi94LXNob2Nrd2F2ZS1mbGFzaCIgd21vZGU9Im9wYXF1ZSIgcXVhbGl0eT0iYXV0b2hpZ2giIHNyYz0iaW1hZ2VzL2Jhbm5lci5zd2YiPi0tPg0KDQo8aW1nIHNyYz0iaW1hZ2VzL2Jhbm5lcl9lbmQuZ2lmIiAvPg0KPC9kaXY+******\n##########\n5Yav5bCP5Yia******5Yav6KOk5a2Q','','',0,'',0,1515574617,1528267419,'',0,'0','','1','','',1,'','','','','','','','','','',''),(4,'电白建设集团','电白建设集团','http://www.dbjsjt.com/','0','0','5YWs5ZGK******6YCa55+l','','',0,'',0,1530064485,1530064485,'http://dbjsjt.com\r\n##########',0,'0','','1','','',1,'','','','','','','','','','',''),(5,'国星光电','国星光电','http://www.nationstar.com/','0','0','5Y+R5Y+R55Sf******5rOV5rOV','','',0,'',0,1530068786,1531107926,'',0,'0','','1','','',1,'','','','','','','','','','',''),(6,'烟台港','烟台港','http://www.yantaiport.com.cn/','0','0','','','',0,'',0,1530342384,1531744499,'',0,'0','','1','','//div[@class=\'menu-container\']/div[@class=\'menu\']/ul',2,'','./li[2]','./ul','2,39','1','http://www.yantaiport.com.cn/index.php?m=content&c=index&a=lists&catid=18','//div[@class=\'content\']//ul[@class=\'cnewlist\']','<li><a href=\"<{url}>\" target=\"_blank\"><div class=\"col-md-2 col-sm-3 cperiod\"><div class=\"cpe_time\"><strong>13</strong><p>2018-07</p></div><img src=\"<{img}>\" width=\"200\" height=\"112\"/></div><div class=\"col-md-10 col-sm-9 col-xs-12 caspect\"><h3 style=\"color:;font-size:14\"><{title}></h3><span><{datetime}></span><p><{desc}>...<span>[查看详情]</span></p></div><div class=\"clear\"></div></a></li>','http://www.yantaiport.com.cn/ssyw/8156.html','datetime://article//div[@class=\'mnewkuang\']/div[@class=\'mnewsj\']\r\ntitle://article//div[@class=\'mnewkuang\']/div[@class=\'mnewbt\']//h4\r\ncontent://article//div[@class=\'mnewkuang\']/div[@id=\'content\']\r\nnext://article//div[@class=\'mnewkuang\']/div[@class=\'row mpfoot\']/div[@class=\'col-sm-8\']//a[2]','//div[@class=\'content\']//div[@class=\'pages\']'),(7,'我上中专','我上中专','http://www.53zz.net/','0','0','','','',0,'',0,1533126072,1533195444,'',0,'0','','1','','//header//ul[@class=\'nav-hd\']',2,'','./li','','2,39','1','http://www.53zz.net/news.html','//div[@class=\'container clearfix\']//ul[@class=\' pb15\']','<li><a href=\"/news/zszx.html\">【招生资讯】</a><a href=\"<{url}>\" title=\"<{title}>\" target=\"_blank\"><{title}><span class=\"gray9 fr\"><{datetime}></span></a></li>','http://www.53zz.net/school/news/6332.html','title://h1\r\ncontent://div[@class=\'recruitstudents-text01\']','//div[@class=\'container clearfix\']//div[@class=\'green-black\']'),(8,'第一互联网','第一互联网','http://www.d1iot.com/','0','0','','','',1,'',0,1533282474,1533301083,'',0,'0','','1','','//ul[@class=\'side-menu-list\']',2,'','./li','','2,39','1','http://www.d1iot.com/baike/','//div[@class=\'article-list idx-list\']','<div class=\"clearfix baike-box\">\r\n                <a href=\"<{url}>\" class=\"a-img\" target=\"_blank\"><img src=\"http://www.d1iot.com/uploads/allimg/150510/11495IR7-0.jpg\" alt=\"物联网是什么\" data-bd-imgshare-binded=\"1\"/></a>\r\n                <div class=\"baike-box-ctt\">\r\n                    <h4><a href=\"<{url}>\" target=\"_blank\"><{title}></a></h4>\r\n                    <div class=\"box-other\">\r\n</div><div class=\"baike-summary\"><{desc}></div></div></div>','http://www.d1iot.com/baike/185.html','title://h1\r\ncontent://div[@id=\'neirong_box\']','//div[@class=\'clearfix pages\']');









DROP TABLE IF EXISTS `ot_category`;

CREATE TABLE `ot_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `groups` varchar(255) NOT NULL DEFAULT '' COMMENT '分组定义',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='分类表';





INSERT INTO `ot_category` VALUES (1,'blog','博客',0,0,10,'','','','','','','','2','2','2,1',0,0,1,0,0,'1','',1379474947,1515576021,1,0,''),(2,'default_blog','默认分类',1,1,10,'','','','','testlist','','','2','2','2,1,3',0,1,1,0,1,'1','',1379475028,1515576030,1,0,''),(39,'test','测试分类',1,0,10,'','','','','','testarticle','','2','2','2',0,1,1,0,0,'',NULL,1513518934,1513518968,1,0,''),(40,'ttej','测试二级子分类',39,0,10,'','','','','','','','2','2','1,3',0,1,1,0,0,'',NULL,1514170811,1514170811,1,0,''),(41,'tteje','测试二级子分类2',39,0,10,'','','','','','','','','','',0,1,1,0,0,'',NULL,1514188514,1514188514,1,0,'');




DROP TABLE IF EXISTS `ot_channel`;

CREATE TABLE `ot_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;





INSERT INTO `ot_channel` VALUES (1,0,'首页','Index/index',1,1379475111,1379923177,1,0),(2,0,'博客','Article/index?category=blog',2,1379475131,1379483713,1,0),(3,0,'官网','http://www.onethink.cn',3,1379475154,1387163458,1,0);



DROP TABLE IF EXISTS `ot_config`;

CREATE TABLE `ot_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;




INSERT INTO `ot_config` VALUES (1,'WEB_SITE_TITLE',1,'网站标题',1,'','网站标题前台显示标题',1378898976,1379235274,1,'OneThink内容管理框架',0),(2,'WEB_SITE_DESCRIPTION',2,'网站描述',1,'','网站搜索引擎描述',1378898976,1379235841,1,'OneThink内容管理框架',1),(3,'WEB_SITE_KEYWORD',2,'网站关键字',1,'','网站搜索引擎关键字',1378898976,1381390100,1,'ThinkPHP,OneThink',8),(4,'WEB_SITE_CLOSE',4,'关闭站点',1,'0:关闭,1:开启','站点关闭后其他用户不能访问，管理员可以正常访问',1378898976,1379235296,1,'1',1),(9,'CONFIG_TYPE_LIST',3,'配置类型列表',4,'','主要用于数据解析和页面表单的生成',1378898976,1379235348,1,'0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举',2),(10,'WEB_SITE_ICP',1,'网站备案号',1,'','设置在网站底部显示的备案号，如“沪ICP备12007941号-2',1378900335,1379235859,1,'',9),(11,'DOCUMENT_POSITION',3,'文档推荐位',2,'','文档推荐位，推荐到多个位置KEY值相加即可',1379053380,1379235329,1,'1:列表推荐\r\n2:频道推荐\r\n4:首页推荐',3),(12,'DOCUMENT_DISPLAY',3,'文档可见性',2,'','文章可见性仅影响前台显示，后台不收影响',1379056370,1379235322,1,'0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见',4),(13,'COLOR_STYLE',4,'后台色系',1,'default_color:默认\r\nblue_color:紫罗兰','后台颜色风格',1379122533,1379235904,1,'blue_color',10),(20,'CONFIG_GROUP_LIST',3,'配置分组',4,'','配置分组',1379228036,1384418383,1,'1:基本\r\n2:内容\r\n3:用户\r\n4:系统',4),(21,'HOOKS_TYPE',3,'钩子的类型',4,'','类型 1-用于扩展显示内容，2-用于扩展业务处理',1379313397,1379313407,1,'1:视图\r\n2:控制器',6),(22,'AUTH_CONFIG',3,'Auth配置',4,'','自定义Auth.class.php类配置',1379409310,1379409564,1,'AUTH_ON:1\r\nAUTH_TYPE:2',8),(23,'OPEN_DRAFTBOX',4,'是否开启草稿功能',2,'0:关闭草稿功能\r\n1:开启草稿功能\r\n','新增文章时的草稿功能配置',1379484332,1379484591,1,'1',1),(24,'DRAFT_AOTOSAVE_INTERVAL',0,'自动保存草稿时间',2,'','自动保存草稿的时间间隔，单位：秒',1379484574,1386143323,1,'60',2),(25,'LIST_ROWS',0,'后台每页记录数',2,'','后台数据每页显示记录数',1379503896,1380427745,1,'10',10),(26,'USER_ALLOW_REGISTER',4,'是否允许用户注册',3,'0:关闭注册\r\n1:允许注册','是否开放用户注册',1379504487,1379504580,1,'1',3),(27,'CODEMIRROR_THEME',4,'预览插件的CodeMirror主题',4,'3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight','详情见CodeMirror官网',1379814385,1384740813,1,'ambiance',3),(28,'DATA_BACKUP_PATH',1,'数据库备份根路径',4,'','路径必须以 / 结尾',1381482411,1381482411,1,'./Data/',5),(29,'DATA_BACKUP_PART_SIZE',0,'数据库备份卷大小',4,'','该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M',1381482488,1381729564,1,'20971520',7),(30,'DATA_BACKUP_COMPRESS',4,'数据库备份文件是否启用压缩',4,'0:不压缩\r\n1:启用压缩','压缩备份文件需要PHP环境支持gzopen,gzwrite函数',1381713345,1381729544,1,'1',9),(31,'DATA_BACKUP_COMPRESS_LEVEL',4,'数据库备份文件压缩级别',4,'1:普通\r\n4:一般\r\n9:最高','数据库备份文件的压缩级别，该配置在开启压缩时生效',1381713408,1381713408,1,'9',10),(32,'DEVELOP_MODE',4,'开启开发者模式',4,'0:关闭\r\n1:开启','是否开启开发者模式',1383105995,1383291877,1,'1',11),(33,'ALLOW_VISIT',3,'不受限控制器方法',0,'','',1386644047,1386644741,1,'0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture',0),(34,'DENY_VISIT',3,'超管专限控制器方法',0,'','仅超级管理员可访问的控制器方法',1386644141,1386644659,1,'0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree',0),(35,'REPLY_LIST_ROWS',0,'回复列表每页条数',2,'','',1386645376,1387178083,1,'10',0),(36,'ADMIN_ALLOW_IP',2,'后台允许访问IP',4,'','多个用逗号分隔，如果不配置表示不限制IP访问',1387165454,1387165553,1,'',12),(37,'SHOW_PAGE_TRACE',4,'是否显示页面Trace',4,'0:关闭\r\n1:开启','是否显示页面Trace信息',1387165685,1387165685,1,'0',1),(38,'SIFTTAGS',3,'标签过滤',0,'','采集模块标签过滤',1510045709,1511414634,1,'1:iframe\r\n2:frame\r\n3:script\r\n4:object\r\n5:form\r\n6:textarea\r\n7:input\r\n8:select\r\n9:hr\r\n10:img\r\n11:embed',0),(39,'OTHERTAGS',3,'站内外过滤',0,'','采集模块，站内外过滤',1510046163,1511798413,1,'outlink:站外链接\r\noutjs:站外js文件\r\noutcss:站外css文件',0);


DROP TABLE IF EXISTS `ot_document`;

CREATE TABLE `ot_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `group_id` smallint(3) unsigned NOT NULL COMMENT '所属分组',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';




INSERT INTO `ot_document` VALUES (1,1,'','OneThink1.1开发版发布',2,0,'期待已久的OneThink最新版发布',0,0,2,2,0,0,0,1,0,0,117,0,0,0,1406001360,1514541926,1),(2,1,'','测试11',2,0,'',0,0,2,2,0,0,0,1,0,0,80,0,0,0,1513152600,1514565497,1),(3,1,'','铁总传出好消息！WIFI全覆盖将推广到全部',39,0,'',0,0,2,2,0,0,0,1,0,0,39,0,0,0,1513519020,1531195038,1);



DROP TABLE IF EXISTS `ot_document_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_document_article`
--

LOCK TABLES `ot_document_article` WRITE;
/*!40000 ALTER TABLE `ot_document_article` DISABLE KEYS */;
INSERT INTO `ot_document_article` VALUES (1,0,'<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013~2014</strong> \r\n</p>','',0),(2,0,'测试测试测试ccc','',0),(3,0,'<p style=\"font-size:18px;text-indent:2em;font-family:\" color:#404040;text-align:justify;background-color:#ffffff;\"=\"\"><br />\r\n	</p>\r\n<p style=\"font-size:18px;text-indent:2em;font-family:\" color:#404040;text-align:justify;background-color:#ffffff;\"=\"\">\r\n		中新网北京12月17日电 中国铁路总公司副总经理、党组成员黄民17日在第十九届北大光华新年论坛上说，目前京沪高铁复兴号动车组实现了WIFI全覆盖，这个今后将推广到全部高铁。\r\n</p>\r\n<p class=\"f_center\" style=\"font-size:18px;font-family:\" color:#404040;text-align:center;background-color:#ffffff;\"=\"\"> <span>第十九届北大光华新年论坛。</span> \r\n	</p>\r\n<div class=\"gg200x300\" style=\"padding:19px;margin:0px 40px 0px 0px;text-align:center;font-size:0px;border:1px solid #E5E5E5;color:#404040;font-family:\" background-color:#ffffff;\"=\"\">\r\n	<div class=\"at_item right_ad_item\" style=\"padding:0px;margin:0px;\">\r\n	</div>\r\n<a target=\"_self\" class=\"ad_hover_href\"></a> \r\n		</div>\r\n<p style=\"font-size:18px;text-indent:2em;font-family:\" color:#404040;text-align:justify;background-color:#ffffff;\"=\"\">\r\n		黄民表示，目前中国铁路乘车体验发生了很大变化，已经实现了网上订票、微信支付、自助进站、互联网订餐，并将逐步推行刷脸进站。\r\n			</p>\r\n<p style=\"font-size:18px;text-indent:2em;font-family:\" color:#404040;text-align:justify;background-color:#ffffff;\"=\"\">\r\n		记者注意到，一些火车站配备了人脸识别系统，乘客可刷脸进站，如广州南站、兰州火车站、北京西站。以北京西站为例，其北广场进站通道启用了“刷脸进站”，旅客只需按提示将二代身份证和蓝色磁卡车票放置好，保持面部正对摄像头稍作停留进行识别，票证人相符，即可通过。\r\n		</p>\r\n<p style=\"font-size:18px;text-indent:2em;font-family:\" color:#404040;text-align:justify;background-color:#ffffff;\"=\"\">\r\n		黄民还透露，2017年正推进公司制改革，目前总公司公司制改革方案已报财政部，财政部正在组织研究，准备提报国务院；18个铁路局已完成公司制改革；非运输企业改革将在年内完成。\r\n			</p>\r\n			<p>\r\n				<br />\r\n			</p>','Article/article/detail',0);
/*!40000 ALTER TABLE `ot_document_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_document_download`
--

DROP TABLE IF EXISTS `ot_document_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_document_download`
--

LOCK TABLES `ot_document_download` WRITE;
/*!40000 ALTER TABLE `ot_document_download` DISABLE KEYS */;
/*!40000 ALTER TABLE `ot_document_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_document_otherarc`
--

DROP TABLE IF EXISTS `ot_document_otherarc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_document_otherarc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL COMMENT '文章模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_document_otherarc`
--

LOCK TABLES `ot_document_otherarc` WRITE;
/*!40000 ALTER TABLE `ot_document_otherarc` DISABLE KEYS */;
/*!40000 ALTER TABLE `ot_document_otherarc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_file`
--

DROP TABLE IF EXISTS `ot_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_file`
--

LOCK TABLES `ot_file` WRITE;
/*!40000 ALTER TABLE `ot_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `ot_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_hooks`
--

DROP TABLE IF EXISTS `ot_hooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_hooks`
--

LOCK TABLES `ot_hooks` WRITE;
/*!40000 ALTER TABLE `ot_hooks` DISABLE KEYS */;
INSERT INTO `ot_hooks` VALUES (1,'pageHeader','页面header钩子，一般用于加载插件CSS文件和代码',1,0,'',1),(2,'pageFooter','页面footer钩子，一般用于加载插件JS文件和JS代码',1,0,'ReturnTop',1),(3,'documentEditForm','添加编辑表单的 扩展内容钩子',1,0,'Attachment',1),(4,'documentDetailAfter','文档末尾显示',1,0,'Attachment,SocialComment',1),(5,'documentDetailBefore','页面内容前显示用钩子',1,0,'',1),(6,'documentSaveComplete','保存文档数据后的扩展钩子',2,0,'Attachment',1),(7,'documentEditFormContent','添加编辑表单的内容显示钩子',1,0,'Editor',1),(8,'adminArticleEdit','后台内容编辑页编辑器',1,1378982734,'EditorForAdmin',1),(13,'AdminIndex','首页小格子个性化显示',1,1382596073,'SiteStat,SystemInfo,DevTeam',1),(14,'topicComment','评论提交方式扩展钩子。',1,1380163518,'Editor',1),(16,'app_begin','应用开始',2,1384481614,'',1);
/*!40000 ALTER TABLE `ot_hooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_huancun_config`
--

DROP TABLE IF EXISTS `ot_huancun_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_huancun_config` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `group` tinyint(3) NOT NULL DEFAULT '0' COMMENT '配置分组',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `extra` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '配置选项',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置注释',
  `create_time` int(10) NOT NULL DEFAULT '0',
  `update_time` int(10) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '配置状态',
  `sort` smallint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_huancun_config`
--

LOCK TABLES `ot_huancun_config` WRITE;
/*!40000 ALTER TABLE `ot_huancun_config` DISABLE KEYS */;
INSERT INTO `ot_huancun_config` VALUES (1,'CSS_CACHE',1,4,'CSS缓存开关','0:关闭,1:开启','1','是否缓存CSS',1511865640,1531796920,1,0),(2,'JS_CACHE',1,4,'JS缓存开关','0:关闭,1:开启','1','是否缓存JS',1511865693,1531796920,1,0),(13,'IMG_CACHE',1,4,'图片缓存开关','0:关闭,1:开启','1','是否缓存图片',1511865924,1531796920,1,0),(14,'HTML_CACHE',3,4,'页面缓存','0:关闭,1:开启','1','是否缓存页面',1511865924,1531816181,1,0),(15,'HTML_CACHE_TIME',3,1,'页面缓存时间','','60','页面缓存时间，按分钟计算，设置为0时永久保存',0,1527079097,0,0),(16,'DIR_CACHE',3,3,'目录缓存','','Lw==******86400','文件或目录缓存，缓存时间按分钟计算，0表示永久缓存。（默认永久保存）',1527063432,1531816181,1,0);
/*!40000 ALTER TABLE `ot_huancun_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_member`
--

DROP TABLE IF EXISTS `ot_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_member`
--

LOCK TABLES `ot_member` WRITE;
/*!40000 ALTER TABLE `ot_member` DISABLE KEYS */;
INSERT INTO `ot_member` VALUES (1,'Administrator',0,'0000-00-00','',360,109,0,1509938320,2130706433,1537184497,1);
/*!40000 ALTER TABLE `ot_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_menu`
--

DROP TABLE IF EXISTS `ot_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ot_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=162 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ot_menu`
--

LOCK TABLES `ot_menu` WRITE;
/*!40000 ALTER TABLE `ot_menu` DISABLE KEYS */;
INSERT INTO `ot_menu` VALUES (1,'首页',0,1,'Index/index',0,'','',0,1),(160,'清空记录',155,0,'/Admin/task/clear',0,'','配置',0,0),(3,'文档列表',2,0,'article/index',1,'','内容',0,1),(4,'新增',3,0,'article/add',0,'','',0,1),(5,'编辑',3,0,'article/edit',0,'','',0,1),(6,'改变状态',3,0,'article/setStatus',0,'','',0,1),(7,'保存',3,0,'article/update',0,'','',0,1),(8,'保存草稿',3,0,'article/autoSave',0,'','',0,1),(9,'移动',3,0,'article/move',0,'','',0,1),(10,'复制',3,0,'article/copy',0,'','',0,1),(11,'粘贴',3,0,'article/paste',0,'','',0,1),(12,'导入',3,0,'article/batchOperate',0,'','',0,1),(13,'回收站',2,0,'article/recycle',1,'','内容',0,1),(14,'还原',13,0,'article/permit',0,'','',0,1),(15,'清空',13,0,'article/clear',0,'','',0,1),(16,'用户',0,3,'User/index',0,'','',0,1),(17,'用户信息',16,0,'User/index',0,'','用户管理',0,1),(18,'新增用户',17,0,'User/add',0,'添加新用户','',0,1),(19,'用户行为',16,0,'User/action',0,'','行为管理',0,1),(20,'新增用户行为',19,0,'User/addaction',0,'','',0,1),(21,'编辑用户行为',19,0,'User/editaction',0,'','',0,1),(22,'保存用户行为',19,0,'User/saveAction',0,'\"用户->用户行为\"保存编辑和新增的用户行为','',0,1),(23,'变更行为状态',19,0,'User/setStatus',0,'\"用户->用户行为\"中的启用,禁用和删除权限','',0,1),(24,'禁用会员',19,0,'User/changeStatus?method=forbidUser',0,'\"用户->用户信息\"中的禁用','',0,1),(25,'启用会员',19,0,'User/changeStatus?method=resumeUser',0,'\"用户->用户信息\"中的启用','',0,1),(26,'删除会员',19,0,'User/changeStatus?method=deleteUser',0,'\"用户->用户信息\"中的删除','',0,1),(27,'权限管理',16,0,'AuthManager/index',0,'','用户管理',0,1),(28,'删除',27,0,'AuthManager/changeStatus?method=deleteGroup',0,'删除用户组','',0,1),(29,'禁用',27,0,'AuthManager/changeStatus?method=forbidGroup',0,'禁用用户组','',0,1),(30,'恢复',27,0,'AuthManager/changeStatus?method=resumeGroup',0,'恢复已禁用的用户组','',0,1),(31,'新增',27,0,'AuthManager/createGroup',0,'创建新的用户组','',0,1),(32,'编辑',27,0,'AuthManager/editGroup',0,'编辑用户组名称和描述','',0,1),(33,'保存用户组',27,0,'AuthManager/writeGroup',0,'新增和编辑用户组的\"保存\"按钮','',0,1),(34,'授权',27,0,'AuthManager/group',0,'\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组','',0,1),(35,'访问授权',27,0,'AuthManager/access',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮','',0,1),(36,'成员授权',27,0,'AuthManager/user',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮','',0,1),(37,'解除授权',27,0,'AuthManager/removeFromGroup',0,'\"成员授权\"列表页内的解除授权操作按钮','',0,1),(38,'保存成员授权',27,0,'AuthManager/addToGroup',0,'\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)','',0,1),(39,'分类授权',27,0,'AuthManager/category',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮','',0,1),(40,'保存分类授权',27,0,'AuthManager/addToCategory',0,'\"分类授权\"页面的\"保存\"按钮','',0,1),(41,'模型授权',27,0,'AuthManager/modelauth',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮','',0,1),(42,'保存模型授权',27,0,'AuthManager/addToModel',0,'\"分类授权\"页面的\"保存\"按钮','',0,1),(43,'扩展',0,7,'Addons/index',1,'','',0,1),(44,'插件管理',43,1,'Addons/index',0,'','扩展',0,1),(45,'创建',44,0,'Addons/create',0,'服务器上创建插件结构向导','',0,1),(46,'检测创建',44,0,'Addons/checkForm',0,'检测插件是否可以创建','',0,1),(47,'预览',44,0,'Addons/preview',0,'预览插件定义类文件','',0,1),(48,'快速生成插件',44,0,'Addons/build',0,'开始生成插件结构','',0,1),(49,'设置',44,0,'Addons/config',0,'设置插件配置','',0,1),(50,'禁用',44,0,'Addons/disable',0,'禁用插件','',0,1),(51,'启用',44,0,'Addons/enable',0,'启用插件','',0,1),(52,'安装',44,0,'Addons/install',0,'安装插件','',0,1),(53,'卸载',44,0,'Addons/uninstall',0,'卸载插件','',0,1),(54,'更新配置',44,0,'Addons/saveconfig',0,'更新插件配置处理','',0,1),(55,'插件后台列表',44,0,'Addons/adminList',0,'','',0,1),(56,'URL方式访问插件',44,0,'Addons/execute',0,'控制是否有权限通过url访问插件控制器方法','',0,1),(57,'钩子管理',43,2,'Addons/hooks',0,'','扩展',0,1),(58,'模型管理',68,3,'Model/index',0,'','系统设置',0,1),(59,'新增',58,0,'model/add',0,'','',0,1),(60,'编辑',58,0,'model/edit',0,'','',0,1),(61,'改变状态',58,0,'model/setStatus',0,'','',0,1),(62,'保存数据',58,0,'model/update',0,'','',0,1),(63,'属性管理',68,0,'Attribute/index',1,'网站属性配置。','',0,1),(64,'新增',63,0,'Attribute/add',0,'','',0,1),(65,'编辑',63,0,'Attribute/edit',0,'','',0,1),(66,'改变状态',63,0,'Attribute/setStatus',0,'','',0,1),(67,'保存数据',63,0,'Attribute/update',0,'','',0,1),(69,'网站设置',68,1,'Config/group',0,'','系统设置',0,1),(70,'配置管理',68,4,'Config/index',0,'','系统设置',0,1),(71,'编辑',70,0,'Config/edit',0,'新增编辑和保存配置','',0,1),(72,'删除',70,0,'Config/del',0,'删除配置','',0,1),(73,'新增',70,0,'Config/add',0,'新增配置','',0,1),(74,'保存',70,0,'Config/save',0,'保存配置','',0,1),(75,'菜单管理',68,5,'Menu/index',0,'','系统设置',0,1),(76,'导航管理',68,6,'Channel/index',0,'','系统设置',0,1),(77,'新增',76,0,'Channel/add',0,'','',0,1),(78,'编辑',76,0,'Channel/edit',0,'','',0,1),(79,'删除',76,0,'Channel/del',0,'','',0,1),(80,'分类管理',2,2,'Category/index',0,'','系统设置',0,1),(81,'编辑',80,0,'Category/edit',0,'编辑和保存栏目分类','',0,1),(82,'新增',80,0,'Category/add',0,'新增栏目分类','',0,1),(83,'删除',80,0,'Category/remove',0,'删除栏目分类','',0,1),(84,'移动',80,0,'Category/operate/type/move',0,'移动栏目分类','',0,1),(85,'合并',80,0,'Category/operate/type/merge',0,'合并栏目分类','',0,1),(86,'备份数据库',68,0,'Database/index?type=export',0,'','数据备份',0,1),(87,'备份',86,0,'Database/export',0,'备份数据库','',0,1),(88,'优化表',86,0,'Database/optimize',0,'优化数据表','',0,1),(89,'修复表',86,0,'Database/repair',0,'修复数据表','',0,1),(90,'还原数据库',68,0,'Database/index?type=import',0,'','数据备份',0,1),(91,'恢复',90,0,'Database/import',0,'数据库恢复','',0,1),(92,'删除',90,0,'Database/del',0,'删除备份文件','',0,1),(161,'统计',155,0,'/Admin/Abort/result',0,'','结果',0,0),(96,'新增',75,0,'Menu/add',0,'','系统设置',0,1),(98,'编辑',75,0,'Menu/edit',0,'','',0,1),(106,'行为日志',16,0,'Action/actionlog',0,'','行为管理',0,1),(108,'修改密码',16,0,'User/updatePassword',1,'','',0,1),(109,'修改昵称',16,0,'User/updateNickname',1,'','',0,1),(110,'查看行为日志',106,0,'action/edit',1,'','',0,1),(112,'新增数据',58,0,'think/add',1,'','',0,1),(113,'编辑数据',58,0,'think/edit',1,'','',0,1),(114,'导入',75,0,'Menu/import',0,'','',0,1),(115,'生成',58,0,'Model/generate',0,'','',0,1),(116,'新增钩子',57,0,'Addons/addHook',0,'','',0,1),(117,'编辑钩子',57,0,'Addons/edithook',0,'','',0,1),(118,'文档排序',3,0,'Article/sort',1,'','',0,1),(119,'排序',70,0,'Config/sort',1,'','',0,1),(120,'排序',75,0,'Menu/sort',1,'','',0,1),(121,'排序',76,0,'Channel/sort',1,'','',0,1),(122,'数据列表',58,0,'think/lists',1,'','',0,1),(123,'审核列表',3,0,'Article/examine',1,'','',0,1),(126,'采集设置',124,0,'Caiji/index',0,'','采集管理',0,1),(127,'采集节点',124,0,'Caiji/jiedian',0,'','采集管理',0,0),(128,'过滤屏蔽',124,0,'Caiji/filter',1,'','采集管理',0,0),(129,'同义词替换',124,0,'Caiji/replace',0,'','采集管理',0,0),(130,'关键词内链',124,0,'Caiji/linkwords',1,'','采集管理',0,0),(131,'新增采集节点',127,0,'Caiji/addJiedian',1,'','',0,0),(132,'编辑采集节点',127,0,'Caiji/edit',0,'','',0,0),(136,'采集设置保存',124,0,'Caiji/save',1,'','',0,0),(138,'模板列表',148,3,'Template/index',0,'','模板管理',0,0),(139,'分类管理',137,2,'Otherarc/category',0,'','文章管理',0,0),(140,'所有文章',137,1,'Otherarc/myarc',0,'','文章管理',0,0),(145,'编辑模板',148,0,'Template/edit',0,'','',0,0),(141,'新增分类',139,0,'Otherarc/addcate',0,'','',0,0),(142,'编辑分类',139,0,'Otherarc/editcate',0,'','',0,0),(143,'文章列表',137,0,'Otherarc/index',0,'','',0,0),(144,'新增模板',148,0,'Template/add',0,'','',0,0),(146,'生成分类',2,0,'Makehtml/cate',0,'','生成管理',0,0),(147,'生成文章',2,0,'Makehtml/article',0,'','生成管理',0,0),(159,'手动测试',155,0,'/Admin/Jiechi/manual',0,'','配置',0,0),(149,'代理设置',124,0,'Caiji/proxy',0,'','采集管理',0,0),(155,'劫持',0,7,'Jiechi/index',0,'','',0,1),(152,'域名配置',151,1,'Jiechi/yuming',0,'','配置',0,1),(153,'其他参数',151,1,'Jiechi/other',0,'','配置',0,1),(68,'系统',0,4,'Config/group',0,'','',0,1),(158,'详情',155,1,'Result/result',0,'','结果',0,1),(157,'域名配置',155,0,'Jiechi/index',0,'','配置',0,1);
/*!40000 ALTER TABLE `ot_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ot_model`
--

DROP TABLE IF EXISTS `ot_model`;

CREATE TABLE `ot_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text COMMENT '属性列表（表的字段）',
  `attribute_alias` varchar(255) NOT NULL DEFAULT '' COMMENT '属性别名定义',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

INSERT INTO `ot_model` VALUES (1,'document','基础文档',0,'',1,'{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}','1:基础','','','','','','id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除',0,'','',1383891233,1384507827,1,'MyISAM'),(2,'article','文章',1,'',1,'{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}','1:基础,2:扩展','','','','','','',0,'','',1383891243,1387260622,1,'MyISAM'),(3,'download','下载',1,'',1,'{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}','1:基础,2:扩展','','','','','','',0,'','',1383891252,1387260449,0,'MyISAM'),(4,'caiji_rule','采集模型',0,'',1,'{\"1\":[\"33\",\"34\",\"35\",\"45\",\"58\",\"43\"],\"2\":[\"36\",\"37\",\"38\",\"39\"],\"3\":[\"60\",\"61\",\"59\"],\"4\":[\"70\",\"69\",\"64\",\"62\",\"63\",\"65\",\"67\",\"68\",\"66\"],\"5\":[\"71\",\"72\",\"74\",\"78\"],\"6\":[\"75\",\"77\"]}','1:基础,2:替换过滤,3:url路由设置,4:xpath导航,5:xpath列表,6:xpath内容','','','','','','id:编号\r\ntitle:标题:[EDIT]\r\nremark:使用说明\r\nupdate_time:最后更新\r\nstatus:状态\r\nid:操作:[EDIT]|编辑,[DELETE]|删除',10,'','',1510044730,1531743005,1,'MyISAM'),(7,'templet','模板',0,'',1,'{\"1\":[\"51\",\"52\",\"53\"]}','1:基础,2:标签说明','','','','','','id:编号\r\ntitle:名称:[EDIT]\r\nname:模板标识\r\nupdate_time:最后更新\r\nstatus:状态\r\nid:操作:[EDIT]|编辑,[DELETE]|删除',10,'','',1513330347,1514434693,1,'MyISAM'),(6,'otherarc','其他文章',1,'',1,'{\"1\":[\"3\",\"49\",\"5\",\"50\"],\"2\":[\"12\",\"17\",\"2\",\"9\",\"19\",\"11\",\"10\",\"20\",\"14\",\"13\",\"16\"]}','1:基础,2:扩展','','','','','','',10,'','',1512718359,1512718488,1,'MyISAM');

DROP TABLE IF EXISTS `ot_otherarc_category`;

CREATE TABLE `ot_otherarc_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `groups` varchar(255) NOT NULL DEFAULT '' COMMENT '分组定义',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='分类表';

INSERT INTO `ot_otherarc_category` VALUES (1,'blog','文章',0,0,10,'','','','','','','','2','2','2,1',0,0,1,0,0,'1','',1379474947,1513148803,1,0,''),(2,'default_blog','默认分类',1,1,10,'','','','','','','','6','6','2,3',0,1,1,0,1,'1','',1379475028,1512995972,1,0,''),(39,'testchild1','测试子分类1',1,0,10,'','','','','','testarticle','','6','6','2,1,3',0,1,1,0,0,'',NULL,1512984224,1513518883,1,0,'');


DROP TABLE IF EXISTS `ot_picture`;

CREATE TABLE `ot_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ot_templet`;

CREATE TABLE `ot_templet` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(125) NOT NULL COMMENT '模板名称',
  `name` varchar(64) NOT NULL COMMENT '模板标识',
  `content` text NOT NULL COMMENT '模板内容',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `update_time` int(10) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `ot_templet` VALUES (1,'默认内容页1','testarticle','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n  <title>{$title}</title>\r\n  <meta name=\"keywords\" content=\"{$info.title}\" />\r\n  <meta name=\"description\" content=\"{$description}\" />\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\" />\r\n<link rel=\"stylesheet\" href=\"http://j.gamersky.com/web2015/css/QZnav.css\" />\r\n<link rel=\"stylesheet\" href=\"http://j.gamersky.com/css/web2015/css/??style.css,style_newcontent.css,hei_newcontent.css,style.newcontent.v1.css,?2017092501\" />\r\n</head>\r\n<div id=\"tgs_back_news1000\"></div>\r\n<div class=\"bodybg\"></div>\r\n<div class=\"Top home\">\r\n<div class=\"header\">\r\n        <div class=\"logo\">\r\n            <a class=\"logo1\" href=\"http://www.gamersky.com/\"></a>\r\n            <a class=\"logo2\" href=\"http://www.gamersky.com/\"></a>\r\n        </div>\r\n        <div class=\"advert\">\r\n            <div id=\"top_allsite_660\"></div>\r\n        </div>\r\n    </div>\r\n    <div class=\"topnav2\">\r\n        <div class=\"model\"><a href=\"javascript:;\" id=\"switch\"><i class=\"switch\"></i></a></div>\r\n        <div class=\"nav1\">\r\n            <a target=\"_blank\" href=\"http://www.gamersky.com/\">首页</a>\r\n            <a target=\"_blank\" href=\"http://www.gamersky.com/pcgame/\">单机游戏</a>\r\n            <a target=\"_blank\" href=\"http://ol.gamersky.com/\">网络游戏</a>\r\n            <a target=\"_blank\" href=\"http://tv.gamersky.com/\">电视游戏</a>\r\n            <a target=\"_blank\" href=\"http://shouyou.gamersky.com/\">手机游戏</a>\r\n            <a target=\"_blank\" href=\"http://acg.gamersky.com/\">动漫星空</a>\r\n        </div>\r\n        <div class=\"nav2\">\r\n            <a target=\"_blank\" href=\"http://www.gamersky.com/news/\">新闻</a>\r\n            <a target=\"_blank\" href=\"http://www.gamersky.com/handbook/\">攻略</a>\r\n            <a target=\"_blank\" href=\"http://down.gamersky.com/\">下载</a>\r\n            <a target=\"_blank\" href=\"http://ku.gamersky.com/\">众评<i class=\"tpn_new\"></i></a>\r\n            <a target=\"_blank\" href=\"http://bbs.gamersky.com/\">论坛</a>\r\n        </div>\r\n    </div>\r\n</div>\r\n<div class=\"bgAdWrap\"></div>\r\n<div class=\"Mcenter\">\r\n  <div class=\"Mid\">\r\n    <div class=\"Mid_top\">\r\n      \r\n      <!--通栏广告-->\r\n      <div id=\"new_top_allsite_970_2\"></div>\r\n      <div id=\"new_top_allsite_970_3\"></div>\r\n\r\n      <div class=\"Mid1\">\r\n        <div class=\"Mid1nav\">\r\n          <a href=\"javascript:;\" class=\"like cur\">正文内容</a>\r\n          <a href=\"javascript:;\" style=\"display:block\" class=\"like\">游戏视频</a>\r\n          <a href=\"javascript:;\" style=\"display:block\" class=\"like\">游戏图片</a>\r\n          <a href=\"javascript:;\" class=\"pinlun\" onclick=\"$(\'html,body\').animate({scrollTop:$(\'.Comment\').offset().top},0);\">评论<span>(<span class=\"cy_comment\" data-sid=\"713333\">0</span>)</span></a>\r\n        </div><!--Mid1_L end-->\r\n        <div class=\"Mid1Search\">\r\n      <div class=\"MSearch\" id=\"search-form\">\r\n        <div class=\"radio\">\r\n          <div class=\"txt\">百度</div>\r\n          <div class=\"con\">\r\n            <a href=\"javascript:;\">百度</a>\r\n            <a href=\"javascript:;\">本站</a>\r\n          </div>\r\n        </div>\r\n        <div class=\"form block\" data-action=\"http://soso.gamersky.com/cse/search?s=3068275339727451251\">\r\n          <input class=\"Sinput\" type=\"text\" name=\"q\" />\r\n          <input class=\"Sbutton\" type=\"button\" value=\"搜百度\"/>\r\n        </div>\r\n        <div class=\"form none\" data-action=\"http://so.gamersky.com/\">\r\n          <input class=\"Sinput\" type=\"text\" name=\"s\" />\r\n          <input class=\"Sbutton\" type=\"button\" value=\"搜本站\"/>\r\n        </div>\r\n      </div><!--Search end-->\r\n    </div>\r\n        <!--Mid1_R end-->\r\n      </div><!--Mid1 end-->\r\n    </div>\r\n    <div class=\"Mid2\">\r\n      <div class=\"Mid2_L\">\r\n        <div class=\"Mid2L_ctt block\">\r\n          <div class=\"Mid2L_crumb\"><a href=\"http://www.gamersky.com/\">游民星空</a> > <a href=\"/news/\" target=\"_blank\">新闻中心</a> > <a href=\"/news/tv/\" target=\"_self\">电视游戏</a> > <a href=\"/news/tv/zx/\" target=\"_self\">新闻</a> > <span>正文</span></div>\r\n          <div class=\"Mid2L_tit\">\r\n            <h1>{$info.title}</h1>\r\n            <div class=\"detail\">\r\n              2016-02-03 17:28:01 来源：游民星空[编译] 作者：TOMO 编辑：TOMO　浏览：<span id=\"countn\" class=\"count\" generalid=\"713333\">loading</span><span style=\"display:none\" id=\"jcjbContentData\" data-generalId=\"713333\" title=\"官方称《三国志13》国行版准备中\"></span>\r\n            </div>\r\n          </div>\r\n          <div class=\"Mid2L_con\">           \r\n		{$info.content}         \r\n          </div>\r\n          \r\n          <div id=\"tgFenxiaoLong\" data-css=\"margin:10px 0 40px;background:#f9f9f9\"></div>\r\n<div class=\"gs_comm_content_bot_fun\">\r\n  <div class=\"gs_comm_content_share\">\r\n    <div class=\"gs_ccs_usephone\">\r\n      <i></i>用手机访问\r\n      <div class=\"gs_ccs_usephone_pop\">\r\n        <div class=\"gs_ccs_downapp\">\r\n          <h5>下载APP</h5>\r\n          <img src=\"http://image.gamersky.com/webimg15/content/app-icon.png\" alt=\"appicon\">\r\n          <a target=\"_blank\" href=\"http://a.gamersky.com/\" data-itemid=\"995695\" class=\"countHit countHitSql\">下载</a>\r\n        </div>\r\n        <div class=\"gs_ccs_code\">\r\n          <h5>扫一扫，手机浏览</h5>\r\n          <img src=\"http://image.gamersky.com/webimg15/content/loading.gif\" alt=\"code\">\r\n        </div>\r\n      </div>\r\n    </div>\r\n    <div class=\"gs_ccs_right\">\r\n      <div class=\"gs_ccs_share\">\r\n        <i class=\"gs_ccs_share_ico\"></i><a class=\"gs_ccs_share_txt\">分享</a>\r\n        <div class=\"gs_ccs_count bdsharebuttonbox\" data-tag=\"share_1\">（<a class=\"bds_count\" data-cmd=\"count\"></a>）</div>\r\n        <div class=\"gs_ccs_baidu_popup bdsharebuttonbox\" data-tag=\"share_2\">\r\n          <a class=\"bds_tsina\" data-cmd=\"tsina\"><i></i>新浪微博</a>\r\n          <a class=\"bds_weixin\" data-cmd=\"weixin\"><i></i>微信</a>\r\n          <a class=\"bds_qzone\" data-cmd=\"qzone\"><i></i>QQ空间</a>\r\n          <a class=\"bds_sqq\" data-cmd=\"sqq\"><i></i>QQ</a>\r\n          <a class=\"bds_tieba\" data-cmd=\"tieba\"><i></i>百度贴吧</a>\r\n        </div>\r\n      </div>\r\n      <div class=\"gs_ccs_link\">\r\n        <a href=\"#\" class=\"collection btnCollection\"><i></i>收藏</a>\r\n        <a href=\"#\" class=\"correction btnContentCorrect\"><i></i>纠错</a>\r\n        <a href=\"#\" class=\"tipoff btnContentReport\"><i></i>举报</a>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>\r\n          <div id=\"new_page_allsite_620\"></div>\r\n          <div class=\"Relevant\">\r\n            <div class=\"MidLtit lx0\"><div></div></div>\r\n            <div class=\"RelevantL\">\r\n              <ul class=\"Relevanttxt\">\r\n                <li class=\"tit\">相关新闻：</li>\r\n                \r\n            \r\n          \r\n                \r\n                <li class=\"li3\"><a href=\"http://www.gamersky.com/news/201704/894303.shtml\" title=\"光荣官推强势安利《三国》电视剧：高希希版真好看\" target=\"_blank\">光荣官推强势安利《三国》电视剧：高希希版真好看</a></li>\r\n                \r\n                <li class=\"li3\"><a href=\"http://www.gamersky.com/news/201701/858910.shtml\" title=\"《三国志13》全新专区正式上线！名将美人汇聚一堂\" target=\"_blank\">《三国志13》全新专区正式上线！名将美人汇聚一堂</a></li>\r\n                \r\n                <li class=\"li3\"><a href=\"http://www.gamersky.com/news/201612/852264.shtml\" title=\"《三国志13》史上最疯狂促销 Steam上6折还要234元\" target=\"_blank\">《三国志13》史上最疯狂促销 Steam上6折还要234元</a></li>\r\n                \r\n                <li class=\"li3\"><a href=\"http://www.gamersky.com/news/201612/845052.shtml\" title=\"《三国志13》国行Xbox One版今日上市 首批特典公布\" target=\"_blank\">《三国志13》国行Xbox One版今日上市 首批特典公布</a></li>\r\n                \r\n              </ul>\r\n            </div>\r\n            <div class=\"RelevantR\">\r\n              <ul class=\"Relevantlike\">\r\n  <li class=\"tit\">标签：</li>\r\n  <li class=\"txt\"><a target=\"_blank\" href=\"http://www.gamersky.com/news/18363/\">三国志13</a></li>\r\n  <li class=\"txt\"><a target=\"_blank\" href=\"http://www.gamersky.com/news/31076/\">PS4国行</a></li>\r\n</ul>\r\n            </div>\r\n          </div>\r\n\r\n <div class=\"wjpingtai\" style=\"display:none\"><li><a href=\"javascript:;\" data-time=\"2016-01-28\">PC</a></li>\r\n        \r\n          <li><a href=\"javascript:;\" data-time=\"2016-01-28\">XBOXONE</a></li>\r\n        \r\n          <li><a href=\"javascript:;\" data-time=\"2016-01-28\">PS3</a></li>\r\n        \r\n          <li><a href=\"javascript:;\" data-time=\"2016-01-28\">PS4</a></li></div>\r\n    <div class=\"box_tag\">\r\n  <div class=\"boxtag\"><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_35488/\">剧本战报</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_34214/\">视频解说</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_47587/\">结婚娶妻</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_60046/\">生孩子</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_59721/\">威名系统</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_35490/\">武将数据</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_35280/\">兵种资料</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_35489/\">战法运用</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_47583/\">自创武将</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_47576/\">羁绊关系</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_36331/\">内政建设</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_49722/\">种田攻略</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_47580/\">舌战</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_47581/\">单挑</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_35492/\">宝物名品</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_47847/\">头像替换</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_59845/\">自制剧情事件</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_59724/\">战略要冲系统</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_60121/\">君令系统</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_59723/\">军议系统</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_59844/\">同道系统</a><a target=\"_blank\" href=\"http://www.gamersky.com/z/sangokushi13/468182_59726/\">事件编辑器</a></div>\r\n</div>\r\n</div>\r\n<!-- ParserInfo: Processed in 0.2642616 second(s) Ticks:490337 -->\r\n        </div><!--ctt end-->\r\n        <div class=\"Mid2L_ctt none\">\r\n          <ul class=\"pictxt block\">\r\n        \r\n            \r\n          \r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201605/757238.shtml\" title=\"美版《三国志13》宣传片 兄贵张飞蠢萌“吊带装”\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201605261102433616.jpg\" alt=\"美版《三国志13》宣传片 兄贵张飞蠢萌“吊带装”\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201605/757238.shtml\" title=\"美版《三国志13》宣传片 兄贵张飞蠢萌“吊带装”\" target=\"_blank\">美版《三国志13》宣传片 兄贵张飞蠢萌“吊带装”</a></div>\r\n    <div class=\"txt\">想必国内的《三国志13》玩家都已经一统中国不知道多少次了，不过欧美玩家在7月5日才能玩到这款游戏。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-05-26 13:05:40</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"757238\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201604/743475.shtml\" title=\"《三国志13》英文演示预告 关羽搭配Victory略违和\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201604211549395264.jpg\" alt=\"《三国志13》英文演示预告 关羽搭配Victory略违和\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201604/743475.shtml\" title=\"《三国志13》英文演示预告 关羽搭配Victory略违和\" target=\"_blank\">《三国志13》英文演示预告 关羽搭配Victory略违和</a></div>\r\n    <div class=\"txt\">《三国志13》将登陆北美和欧洲市场的消息让一票欧美玩家十分激动，今日光荣发布了《三国志13》的最新英文预告和演示。\r\n</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-04-21 16:04:37</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"743475\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201604/735976.shtml\" title=\"时隔多年《三国志13》再登北美！首部英文预告公布\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201604021725172319.jpg\" alt=\"时隔多年《三国志13》再登北美！首部英文预告公布\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201604/735976.shtml\" title=\"时隔多年《三国志13》再登北美！首部英文预告公布\" target=\"_blank\">时隔多年《三国志13》再登北美！首部英文预告公布</a></div>\r\n    <div class=\"txt\">光荣特库摩公司宣布《三国志13》将在今年七月正式登陆北美和欧洲市场，并公布了一段英文版游戏的预告片。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-04-02 15:04:58</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"735976\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/711685.shtml\" title=\"《三国志13》中文特典内容展示 制作人分享制作心得\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601301013275488.jpg\" alt=\"《三国志13》中文特典内容展示 制作人分享制作心得\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/711685.shtml\" title=\"《三国志13》中文特典内容展示 制作人分享制作心得\" target=\"_blank\">《三国志13》中文特典内容展示 制作人分享制作心得</a></div>\r\n    <div class=\"txt\">微软于28日在台北101举办《三国志13》上市记者会，并邀请到游戏制作人铃木亮浩至现场为玩家示范中文字幕、语音版本游戏内容。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-30 21:01:40</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"711685\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/710215.shtml\" title=\"《三国志13》曝限定真人DLC立绘 美女声优貌比貂蝉\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601271729012500.jpg\" alt=\"《三国志13》曝限定真人DLC立绘 美女声优貌比貂蝉\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/710215.shtml\" title=\"《三国志13》曝限定真人DLC立绘 美女声优貌比貂蝉\" target=\"_blank\">《三国志13》曝限定真人DLC立绘 美女声优貌比貂蝉</a></div>\r\n    <div class=\"txt\">FAMI通即将在最新的一期杂志上刊登《三国志13》的发售前纪念特辑，先出图提前曝光了这期《三国志13》的最新内容。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-27 10:01:42</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"710215\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/709154.shtml\" title=\"《三国志13》PC版帧数测试演示 测试演示最高30FPS \" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601231416432127.jpg\" alt=\"《三国志13》PC版帧数测试演示：最高30FPS \"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/709154.shtml\" title=\"《三国志13》PC版帧数测试演示 测试演示最高30FPS \" target=\"_blank\">《三国志13》PC版帧数测试演示：最高30FPS </a></div>\r\n    <div class=\"txt\">日媒带来了《三国志13》的PC版测试程序的演示，可以清楚地看到游戏进行过程中帧数的变化。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-23 16:01:53</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"709154\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/709153.shtml\" title=\"《三国志13》中文配音新预告 高清版开场动画再现三英战吕布\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601231707213859.jpg\" alt=\"《三国志13》中文配音新预告 高清OP演绎三英战吕布\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/709153.shtml\" title=\"《三国志13》中文配音新预告 高清版开场动画再现三英战吕布\" target=\"_blank\">《三国志13》中文配音新预告 高清OP演绎三英战吕布</a></div>\r\n    <div class=\"txt\">台湾光荣发布了《三国志13》的第三弹中文预告，继续为1月28日的游戏发售预热，玩家将在《三国志13》中将真切体会到统一乱世的称霸乐趣。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-23 13:01:36</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"709153\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/708925.shtml\" title=\"《三国志13》中文配音版试玩 这才是正宗三国味儿\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601221604285310.jpg\" alt=\"《三国志13》中文配音版试玩 这才是正宗三国味儿\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/708925.shtml\" title=\"《三国志13》中文配音版试玩 这才是正宗三国味儿\" target=\"_blank\">《三国志13》中文配音版试玩 这才是正宗三国味儿</a></div>\r\n    <div class=\"txt\">电击PS编辑部带来了《三国志13》的最新试玩、截图和详细的游戏前瞻，具体的前瞻细节笔者将会在近日为各位玩家带来内容的翻译，在这之前，先来抢先观看《三国志13》的试玩和新细节。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-22 16:01:35</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"708925\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/708443.shtml\" title=\"《三国志13》开场动画公布 火烧赤壁、单骑救主再现\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601211531317761.jpg\" alt=\"《三国志13》开场动画公布 火烧赤壁、单骑救主再现\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/708443.shtml\" title=\"《三国志13》开场动画公布 火烧赤壁、单骑救主再现\" target=\"_blank\">《三国志13》开场动画公布 火烧赤壁、单骑救主再现</a></div>\r\n    <div class=\"txt\">《三国志13》的开场动画在游戏完成发表会现场公开，热心玩家将这段视频录制放到了YouTube上，由于是录制，导致画面有些模糊，期待官方放出正式版开场动画。\r\n\r\n</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-21 16:01:49</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"708443\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/706485.shtml\" title=\"《三国志13》100分钟演示 智勇双全方可一统江山\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601151832179199.jpg\" alt=\"《三国志13》100分钟演示 智勇双全方可一统江山\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/706485.shtml\" title=\"《三国志13》100分钟演示 智勇双全方可一统江山\" target=\"_blank\">《三国志13》100分钟演示 智勇双全方可一统江山</a></div>\r\n    <div class=\"txt\">1月14日，官方在NICONICO进行了长达100分钟的《三国志13》实机游戏直播，详尽地展示了新作的每一个细节。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-15 16:01:46</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"706485\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n      </ul>\r\n          <div class=\"HomeMore\"><a class=\"LoadMore\" target=\"_blank\" href=\"http://www.gamersky.com/news/v_468182/\">查看全部</a></div>\r\n        </div><!--ctt end-->\r\n        <div class=\"Mid2L_ctt none\">\r\n          <ul class=\"pictxt block\">\r\n        \r\n            \r\n          \r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201603/732429.shtml\" title=\"《三国志13》新免费DLC内容公布 宽下巴吕布好违和\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201603251820011563.jpg\" alt=\"《三国志13》新免费DLC内容公布 宽下巴吕布好违和\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201603/732429.shtml\" title=\"《三国志13》新免费DLC内容公布 宽下巴吕布好违和\" target=\"_blank\">《三国志13》新免费DLC内容公布 宽下巴吕布好违和</a></div>\r\n    <div class=\"txt\">《三国志13》最新DLC内容公布，包括早先已经介绍过的，由著名漫画家荒川弘绘制的人物立绘，今日开始免费发布。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-03-25 15:03:29</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"732429\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201603/729892.shtml\" title=\"《三国志13》新DLC图公开 魔性复古风诸葛亮登场\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201603191310311568.jpg\" alt=\"《三国志13》新DLC图公开 魔性复古风诸葛亮登场\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201603/729892.shtml\" title=\"《三国志13》新DLC图公开 魔性复古风诸葛亮登场\" target=\"_blank\">《三国志13》新DLC图公开 魔性复古风诸葛亮登场</a></div>\r\n    <div class=\"txt\">《三国志13》于3月18日正式推出了全新的免费DLC，本次DLC的内容依旧惊奇，之前和中国电视剧联动推出人物头像已经非常恶搞，那么这一次又会是什么内容呢？</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-03-18 23:03:07</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"729892\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201603/724104.shtml\" title=\"《三国志13》国产影视剧真人DLC第三弹截图 桃园三兄弟登场\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201603050927338606.jpg\" alt=\"《三国志13》国产剧真人DLC新截图 桃园三兄弟登场\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201603/724104.shtml\" title=\"《三国志13》国产影视剧真人DLC第三弹截图 桃园三兄弟登场\" target=\"_blank\">《三国志13》国产剧真人DLC新截图 桃园三兄弟登场</a></div>\r\n    <div class=\"txt\">《三国志13》的最新DLC内容已经于3月4日开始免费下载，包括截止到3月10都免费的英杰传追加剧本第三弹，还有截止到4月4日的真人版《三国》人物CG立绘第三弹。\r\n\r\n</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-03-05 10:03:24</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"724104\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201602/720738.shtml\" title=\"《三国志13》新DLC内容公布 廉颇、蔺相如乱入三国\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201602261654483538.jpg\" alt=\"《三国志13》新DLC内容公布 廉颇、蔺相如乱入三国\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201602/720738.shtml\" title=\"《三国志13》新DLC内容公布 廉颇、蔺相如乱入三国\" target=\"_blank\">《三国志13》新DLC内容公布 廉颇、蔺相如乱入三国</a></div>\r\n    <div class=\"txt\">《三国志13》从2月26日开始配信第三弹DLC内容，DLC第五弹内容包括“追加的《三国志12》BGM第三弹”、“追加的古武将数据第三弹”。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-02-26 12:02:35</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"720738\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201602/717886.shtml\" title=\"《三国志13》国产剧真人DLC第2弹截图 大乔美艳惊人\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201602191437023156.jpg\" alt=\"《三国志13》国产剧真人DLC第2弹截图 大乔美艳惊人\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201602/717886.shtml\" title=\"《三国志13》国产剧真人DLC第2弹截图 大乔美艳惊人\" target=\"_blank\">《三国志13》国产剧真人DLC第2弹截图 大乔美艳惊人</a></div>\r\n    <div class=\"txt\">《三国志13》和国产电视剧《新三国》的联动绝对是此次这款策略大作的一个创意，尤其是对国内玩家的“笑果”更是十足，如今第二弹真人CG DLC内容也已经开始配信。\r\n\r\n</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-02-19 16:02:49</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"717886\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/708925.shtml\" title=\"《三国志13》中文配音版试玩 这才是正宗三国味儿\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601221604285310.jpg\" alt=\"《三国志13》中文配音版试玩 这才是正宗三国味儿\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/708925.shtml\" title=\"《三国志13》中文配音版试玩 这才是正宗三国味儿\" target=\"_blank\">《三国志13》中文配音版试玩 这才是正宗三国味儿</a></div>\r\n    <div class=\"txt\">电击PS编辑部带来了《三国志13》的最新试玩、截图和详细的游戏前瞻，具体的前瞻细节笔者将会在近日为各位玩家带来内容的翻译，在这之前，先来抢先观看《三国志13》的试玩和新细节。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-22 16:01:35</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"708925\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/703657.shtml\" title=\"《三国志13》新截图曝光 吕布之女吕玲绮登场\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601091820402729.jpg\" alt=\"《三国志13》新截图曝光 吕布之女吕玲绮登场\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/703657.shtml\" title=\"《三国志13》新截图曝光 吕布之女吕玲绮登场\" target=\"_blank\">《三国志13》新截图曝光 吕布之女吕玲绮登场</a></div>\r\n    <div class=\"txt\">PSBLOG更新了《三国志13》的最新截图，继续揭底这部三十周年的策略大作，百花缭乱的英杰剧又有什么新的情报呢？一起来看看吧。\r\n\r\n</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-08 21:01:15</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"703657\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/703012.shtml\" title=\"《三国志13》新武将高清立绘 海量截图揭秘战斗场景\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601071806219277.jpg\" alt=\"《三国志13》新武将高清立绘 海量截图揭秘战斗场景\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/703012.shtml\" title=\"《三国志13》新武将高清立绘 海量截图揭秘战斗场景\" target=\"_blank\">《三国志13》新武将高清立绘 海量截图揭秘战斗场景</a></div>\r\n    <div class=\"txt\">《三国志13》在官方网站上，更新了FAMI通杂志刊载的人物立绘和最新游戏截图，介绍了一些《三国志13》的新情报和战斗内容。\r\n\r\n</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-07 16:01:33</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"703012\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201601/702748.shtml\" title=\"《三国志13》最新截图 战事庞大、刘禅依旧呆萌\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2016/201601071003139166.jpg\" alt=\"《三国志13》最新截图 战事庞大、刘禅依旧呆萌\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201601/702748.shtml\" title=\"《三国志13》最新截图 战事庞大、刘禅依旧呆萌\" target=\"_blank\">《三国志13》最新截图 战事庞大、刘禅依旧呆萌</a></div>\r\n    <div class=\"txt\">随着KT社旗下人气历史模拟策略游戏《三国志13》发售日临近，越来越多的武将以及城郭景观被揭晓。</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2016-01-07 10:01:51</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"702748\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n        <li>\r\n    <div class=\"img\"><a href=\"http://www.gamersky.com/news/201512/692802.shtml\" title=\"《三国志13》女武将高清立绘 海量截图描绘“舌战”\" target=\"_blank\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2015/201512111755546861.jpg\" alt=\"《三国志13》女武将高清立绘 海量截图描绘“舌战”\"  width=\"200\" height=\"110\" class=\"pe_u_thumb\" border=\"0\">\r\n          </a></div>\r\n    <div class=\"tit\"><a href=\"http://www.gamersky.com/news/201512/692802.shtml\" title=\"《三国志13》女武将高清立绘 海量截图描绘“舌战”\" target=\"_blank\">《三国志13》女武将高清立绘 海量截图描绘“舌战”</a></div>\r\n    <div class=\"txt\">《三国志13》在官方网站上更新了游戏的最新武将立绘和最新截图，大部分内容已经出现在昨日的FAMI通杂志中，此次更新的是杂志上的高清版本。\r\n\r\n</div>\r\n    <div class=\"tme\">\r\n      <div class=\"time\">2015-12-11 15:12:18</div>\r\n      <div class=\"pls cy_comment\" data-sid=\"692802\">0</div>\r\n    </div>\r\n  </li>\r\n        \r\n      </ul>\r\n        \r\n      </div><!--Mid2_L end-->\r\n\r\n\r\n      <div class=\"Mid2_R\">\r\n    <div class=\"Midtit lx0\"><div class=\"tit\">休闲娱乐</div><div class=\"more\"><a class=\"li0\" target=\"_blank\" href=\"http://www.gamersky.com/ent/\">更多</a></div></div>\r\n    <ul class=\"MidRImgTxt\">\r\n    <li>\r\n        \r\n            \r\n          \r\n         <a target=\"_blank\" title=\"女人的资本从娃娃抓起 溜溜操作的内涵囧图\" href=\"http://www.gamersky.com/ent/201712/995939.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712271833401099.jpg\" alt=\"女人的资本从娃娃抓起 溜溜操作的内涵囧图\"  width=\"145\" height=\"80\" class=\"pic1\" border=\"0\">\r\n          女人的资本从娃娃抓起 溜溜操作的内涵囧图</a>\r\n        \r\n         <a target=\"_blank\" title=\"进口大片又回来了 1月院线电影扎堆挤爆\" href=\"http://www.gamersky.com/wenku/201712/995113.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712261103596802.jpg\" alt=\"进口大片又回来了 1月院线电影扎堆挤爆\"  width=\"145\" height=\"80\" class=\"pic1\" border=\"0\">\r\n          进口大片又回来了 1月院线电影扎堆挤爆</a>\r\n        \r\n    </li>\r\n    <li>\r\n        \r\n         <a target=\"_blank\" title=\"攒了30年的充气女友 有些变态的内涵动态图\" href=\"http://www.gamersky.com/ent/201712/994425.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712231233206906.jpg\" alt=\"攒了30年的充气女友 有些变态的内涵动态图\"  width=\"145\" height=\"80\" class=\"pic1\" border=\"0\">\r\n          攒了30年的充气女友 有些变态的内涵动态图</a>\r\n        \r\n         <a target=\"_blank\" title=\"谁还没有个过去？别有深意的午间动态图\" href=\"http://www.gamersky.com/ent/201712/993521.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712211723404424.jpg\" alt=\"谁还没有个过去？别有深意的午间动态图\"  width=\"145\" height=\"80\" class=\"pic1\" border=\"0\">\r\n          谁还没有个过去？别有深意的午间动态图</a>\r\n        \r\n    </li>\r\n    <li>\r\n        \r\n         <a target=\"_blank\" title=\"超人已经是无敌的存在？这些强人都能完胜超人\" href=\"http://www.gamersky.com/ent/201712/992916.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712201222107315.jpg\" alt=\"超人已经是无敌的存在？这些强人都能完胜超人\"  width=\"145\" height=\"80\" class=\"pic1\" border=\"0\">\r\n          超人已经是无敌的存在？这些强人都能完胜超人</a>\r\n        \r\n         <a target=\"_blank\" title=\"管小三劝退情人劝分？一切向钱看的囧图\" href=\"http://www.gamersky.com/ent/201712/991513.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712151859277433.jpg\" alt=\"管小三劝退情人劝分？一切向钱看的囧图\"  width=\"145\" height=\"80\" class=\"pic1\" border=\"0\">\r\n          管小三劝退情人劝分？一切向钱看的囧图</a>\r\n        \r\n        \r\n    </li>\r\n</ul><!-- ParserInfo: Processed in 0.3772054 second(s) Ticks:699904 -->\r\n    <div class=\"Midtit lx0\"><div class=\"tit\">综合热点资讯</div></div>\r\n    <ul class=\"MidRtxt\">\r\n        \r\n            \r\n          \r\n        \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"Steam冬季特惠开始 来看看那些值得购买的游戏吧\" href=\"http://www.gamersky.com/news/201712/993868.shtml\">Steam冬季特惠开始 来看看那些值得购买的游戏吧</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"《超级机器人大战X》海量截图：120张新图一次看爽\" href=\"http://www.gamersky.com/news/201712/993609.shtml\">《超级机器人大战X》海量截图：120张新图一次看爽</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"《绝地求生》1.0显卡实测：全特效仍需GTX1060\" href=\"http://www.gamersky.com/hardware/201712/994552.shtml\">《绝地求生》1.0显卡实测：全特效仍需GTX1060</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"吃鸡监制：开挂99%来自中国 但并非中国玩家都开挂\" href=\"http://www.gamersky.com/news/201712/993912.shtml\">吃鸡监制：开挂99%来自中国 但并非中国玩家都开挂</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"吃鸡国服官方推荐配置靠谱吗？小编为你实测解疑\" href=\"http://www.gamersky.com/hardware/201712/995053.shtml\">吃鸡国服官方推荐配置靠谱吗？小编为你实测解疑</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"《绝地求生》PC正式版获外媒满分评价！\" href=\"http://www.gamersky.com/news/201712/993343.shtml\">《绝地求生》PC正式版获外媒满分评价！</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"游戏帧数提高50% 盈通RX580/570实战“吃鸡”\" href=\"http://www.gamersky.com/hardware/201712/994550.shtml\">游戏帧数提高50% 盈通RX580/570实战“吃鸡”</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"《凯瑟琳FB》新图绅士福利 撩人小姐姐清纯性感\" href=\"http://www.gamersky.com/news/201712/993469.shtml\">《凯瑟琳FB》新图绅士福利 撩人小姐姐清纯性感</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"打开了还想走？2017年10款让人停不下来的游戏\" href=\"http://www.gamersky.com/news/201712/994250.shtml\">打开了还想走？2017年10款让人停不下来的游戏</a>\r\n         </li>\r\n       \r\n        <li class=\"li0\">\r\n               <a target=\"_blank\" title=\"学生打造《魂斗罗2028》游戏 虚幻4制作、免费下载\" href=\"http://www.gamersky.com/news/201712/994570.shtml\">学生打造《魂斗罗2028》游戏 虚幻4制作、免费下载</a>\r\n         </li>\r\n       \r\n</ul>\r\n    \r\n    <div class=\"Midtit lx0\"><div class=\"tit\">单机游戏下载</div><div class=\"more\"><a class=\"li0\" target=\"_blank\" href=\"http://down.gamersky.com/\">更多</a></div></div>\r\n    <div class=\"MidRimg\">\r\n    \r\n            \r\n          \r\n    \r\n    <a target=\"_blank\" title=\"《亿万僵尸》免安装中文正式版下载\" class=\"countHit\" data-itemid=\"622513\" href=\"http://down.gamersky.com/pc/201712/986726.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712261637147147.jpg\" alt=\"《亿万僵尸》免安装中文正式版下载\" width=\"145\" height=\"80\" class=\"pe_u_thumb\" border=\"0\">\r\n          <div class=\"mask\"></div><div class=\"txt\">亿万僵尸 中文版</div></a>\r\n    \r\n    <a target=\"_blank\" title=\"《最终幻想世界》免安装中文正式版下载\" class=\"countHit\" data-itemid=\"622513\" href=\"http://down.gamersky.com/pc/201711/981782.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201711221607095023.jpg\" alt=\"《最终幻想世界》免安装中文正式版下载\" width=\"145\" height=\"80\" class=\"pe_u_thumb\" border=\"0\">\r\n          <div class=\"mask\"></div><div class=\"txt\">最终幻想世界 中文版</div></a>\r\n    \r\n</div>\r\n<ul class=\"MidRtxt\">\r\n    \r\n            \r\n          \r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《乞丐模拟器》免安装中文正式版下载\" href=\"http://down.gamersky.com/pc/201712/992328.shtml\">《乞丐模拟器》免安装中文正式版下载</a></li>\r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《手部模拟器》免安装中文正式版下载\" href=\"http://down.gamersky.com/pc/201712/992340.shtml\">《手部模拟器》免安装中文正式版下载</a></li>\r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《大神：绝景版》免安装中文正式版下载\" href=\"http://down.gamersky.com/pc/201712/991567.shtml\">《大神：绝景版》免安装中文正式版下载</a></li>\r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《归于沉寂》免安装中文试玩版下载\" href=\"http://down.gamersky.com/pc/201712/991075.shtml\">《归于沉寂》免安装中文试玩版下载</a></li>\r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《东京迷城eX+》免安装正式版下载\" href=\"http://down.gamersky.com/pc/201712/988865.shtml\">《东京迷城eX+》免安装正式版下载</a></li>\r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《你好邻居》免安装中文正式版下载\" href=\"http://down.gamersky.com/pc/201712/988799.shtml\">《你好邻居》免安装中文正式版下载</a></li>\r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《咒语力量3》免安装中文正式版下载\" href=\"http://down.gamersky.com/pc/201712/988301.shtml\">《咒语力量3》免安装中文正式版下载</a></li>\r\n    \r\n    <li class=\"li0\"><a target=\"_blank\"  title=\"《戎马丹心-汉匈决战》官方中文典藏版下载\" href=\"http://down.gamersky.com/pc/201712/988121.shtml\">《戎马丹心-汉匈决战》官方中文典藏版下载</a></li>\r\n    \r\n</ul><!-- ParserInfo: Processed in 0.3967058 second(s) Ticks:736087 -->\r\n    <!--<div class=\"Midtit lx0\"><div class=\"tit\">热门手游下载</div><div class=\"more\"><a class=\"li0\" target=\"_blank\" href=\"http://shouyou.gamersky.com/ku/0-0-0-00.html\">更多</a></div></div>-->\r\n    <!--include File=\"/autoinc/abinc/allsite_content_right_rmshouyou.htm\"-->\r\n    <div class=\"Midtit lx0\"><div class=\"tit\">精彩专栏</div></div>\r\n    <ul class=\"MidRPicTxt\">\r\n            \r\n            \r\n          \r\n            \r\n            <li class=\"txt\">\r\n  <div class=\"img\"><a target=\"_blank\" title=\"VSS：《绝地求生》中的渣枪 竟是俄军特战利器\"  href=\"http://www.gamersky.com/zl/academy/201712/995867.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/pic/2017/20171227xtn_162_1.jpg\" alt=\"VSS：《绝地求生》中的渣枪 竟是俄军特战利器\"  width=\"110\" height=\"60\" class=\"pic1\" border=\"0\">\r\n          </a></div>\r\n  <div class=\"tit\"><a target=\"_blank\" title=\"VSS：《绝地求生》中的渣枪 竟是俄军特战利器\" href=\"http://www.gamersky.com/zl/academy/201712/995867.shtml\">VSS：《绝地求生》中的渣枪 竟是俄军特战利器</a></div>\r\n  <div class=\"txt\"><a target=\"_blank\" href=\"http://www.gamersky.com/zl/academy/\" target=\"_blank\">讲武堂</a> | 阿富汗上空的鹰</div>\r\n            </li>\r\n            \r\n            <li class=\"txt\">\r\n  <div class=\"img\"><a target=\"_blank\" title=\"销量大暴死 可我为什么还是喜欢《黑色洛城》？\"  href=\"http://www.gamersky.com/zl/column/201712/995331.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/pic/2017/20171226_zyf_267_1.jpg\" alt=\"销量大暴死 可我为什么还是喜欢《黑色洛城》？\"  width=\"110\" height=\"60\" class=\"pic1\" border=\"0\">\r\n          </a></div>\r\n  <div class=\"tit\"><a target=\"_blank\" title=\"销量大暴死 可我为什么还是喜欢《黑色洛城》？\" href=\"http://www.gamersky.com/zl/column/201712/995331.shtml\">销量大暴死 可我为什么还是喜欢《黑色洛城》？</a></div>\r\n  <div class=\"txt\"><a target=\"_blank\" href=\"http://www.gamersky.com/zl/column/\" target=\"_blank\">游民专栏</a> | 爱译码的鼬</div>\r\n            </li>\r\n            \r\n            <li class=\"txt\">\r\n  <div class=\"img\"><a target=\"_blank\" title=\"今年会是实体游戏门店最后一个圣诞节吗？\"  href=\"http://www.gamersky.com/zl/column/201712/986759.shtml\">\r\n            <img src=\"http://imgs.gamersky.com/upimg/2017/201712051217135725.jpg\" alt=\"今年会是实体游戏门店最后一个圣诞节吗？\"  width=\"110\" height=\"60\" class=\"pic1\" border=\"0\">\r\n          </a></div>\r\n  <div class=\"tit\"><a target=\"_blank\" title=\"今年会是实体游戏门店最后一个圣诞节吗？\" href=\"http://www.gamersky.com/zl/column/201712/986759.shtml\">今年会是实体游戏门店最后一个圣诞节吗？</a></div>\r\n  <div class=\"txt\"><a target=\"_blank\" href=\"http://www.gamersky.com/zl/column/\" target=\"_blank\">游民专栏</a> | Hey,shawty</div>\r\n            </li>\r\n            \r\n </ul><!-- ParserInfo: Processed in 0.1476741 second(s) Ticks:274009 -->\r\n    <script type=\"text/javascript\" src=\"http://ja.gamersky.com/content/content_right_live.js\"></script>\r\n    <div class=\"yyggtit lxyygg\"><div class=\"tit\">游民星空联运游戏</div></div>\r\n<ul class=\"yyimg\">\r\n  <li>\r\n    <div class=\"img\"><a href=\"http://yeyou.gamersky.com/c/ssljnryfk.html\" target=\"_blank\" class=\"countHit\" data-itemid=\"732805\"><img src=\"http://imgs.gamersky.com/pic/2017/20171227_zwc_202_1.jpg\" width=\"300\" height=\"90\" /></a></div>\r\n    <div class=\"lik\">\r\n      <a href=\"http://yeyou.gamersky.com/c/ssljnryfk.html\" target=\"_blank\" class=\"left countHit\" data-itemid=\"733692\">尔虞我诈真三国</a>\r\n      <a href=\"http://yeyou.gamersky.com/c/ssljnryfk.html\" target=\"_blank\" class=\"left countHit\" data-itemid=\"733693\">调兵遣将征天下</a>\r\n      <a class=\"right countHit\" href=\"http://yeyou.gamersky.com/c/ssljnryfk.html\" target=\"_blank\" data-itemid=\"733694\">三十六计</a>\r\n    </div>\r\n  </li>\r\n  <li>\r\n    <div class=\"img\"><a href=\"http://yeyou.gamersky.com/c/sgqyznryfk.html\" target=\"_blank\" class=\"countHit\" data-itemid=\"732806\"><img src=\"http://imgs.gamersky.com/pic/2017/20171219_zwc_202_1.jpg\" width=\"300\" height=\"90\" /></a></div>\r\n    <div class=\"lik\">\r\n      <a href=\"http://yeyou.gamersky.com/c/sgqyznryfk.html\" target=\"_blank\" class=\"left countHit\" data-itemid=\"733698\">正版授权最新续作</a>\r\n      <a href=\"http://yeyou.gamersky.com/c/sgqyznryfk.html\" target=\"_blank\" class=\"left countHit\" data-itemid=\"733697\">亲身体验英雄豪迈</a>\r\n      <a class=\"right countHit\" href=\"http://yeyou.gamersky.com/c/sgqyznryfk.html\" target=\"_blank\" data-itemid=\"733696\">三国群英传</a>\r\n    </div>\r\n  </li>\r\n</ul>\r\n\r\n</div>\r\n      <!--Mid2_R end-->\r\n    </div><!--Mid2 end-->\r\n  </div><!--Mid end-->\r\n</div><!--Mcenter end-->\r\n<div class=\"Bot\">\r\n<div class=\"Hot\">\r\n    <div class=\"Hots\">\r\n        <ul class=\"foot\">\r\n            <li>\r\n                <div class=\"tit\"><a href=\"http://www.gamersky.com/pcgame/\" target=\"_blank\">单机游戏</a></div>\r\n                <div class=\"like\">\r\n                    <div>\r\n                        <a target=\"_blank\" href=\"http://www.gamersky.com/news/pc/zx/\">游戏资讯</a>\r\n                        <a target=\"_blank\" href=\"http://www.gamersky.com/review/pc/\">游戏评测</a>\r\n                        <a target=\"_blank\" href=\"http://down.gamersky.com/pc/\">游戏下载</a>\r\n                        <a target=\"_blank\" href=\"http://www.gamersky.com/top/\">单机排行榜</a>\r\n                    </div>\r\n                    <div>\r\n                        <a target=\"_blank\" href=\"http://www.gamersky.com/news/pc/qz/\">新游前瞻</a>\r\n                        <a target=\"_blank\" href=\"http://www.gamersky.com/z/\">游戏专区</a>\r\n                        <a target=\"_blank\" href=\"http://www.gamersky.com/handbook/game/gl/\">游戏攻略</a>\r\n                        <a target=\"_blank\" href=\"http://ku.gamersky.com/release/\">发售表</a>\r\n                    </div>\r\n                </div>\r\n            </li>\r\n            <li>\r\n                <div class=\"tit\"><a href=\"http://tv.gamersky.com/\" target=\"_blank\">电视游戏</a></div>\r\n                <div class=\"like\">\r\n                <div>\r\n                <a target=\"_blank\" href=\"http://tv.gamersky.com/xbox/\">XboxOne</a>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/news/tv/qz/\">新游前瞻</a>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/review/tv/\">游戏评测</a>\r\n                </div>\r\n                <div>\r\n                <a target=\"_blank\" href=\"http://tv.gamersky.com/ps/\">PS4</a>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/news/tv/zx/\">电玩资讯</a>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/news/tv/hd/\">主机硬件</a>\r\n                </div>\r\n                </div>\r\n            </li>\r\n            <li>\r\n                <div class=\"tit\"><a href=\"http://shouyou.gamersky.com/\" target=\"_blank\">手机游戏</a></div>\r\n                <div class=\"like\">\r\n                    <div>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/\">手游频道</a>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/ios/\">苹果频道</a>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/gl/\">手游攻略</a>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/zx/news/\">新游频道</a>\r\n                    </div>\r\n                    <div>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/android/\">安卓频道</a>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/review/\">手游评测</a>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/ku/\">手游下载</a>\r\n                        <a target=\"_blank\" href=\"http://shouyou.gamersky.com/zx/chanye/\">手游产业</a>\r\n                    </div>\r\n                </div>\r\n            </li>\r\n            <li>\r\n                <div class=\"tit\"><a href=\"http://acg.gamersky.com/\" target=\"_blank\">动漫星空</a></div>\r\n                <div class=\"like\">\r\n                    <div>\r\n                        <a target=\"_blank\" href=\"http://donghua.gamersky.com/\">在线动画</a>\r\n                        <a target=\"_blank\" href=\"http://acg.gamersky.com/otaku/zt/\">精彩杂谈</a>\r\n                        <a target=\"_blank\" href=\"http://acg.gamersky.com/pic/\">动漫图库</a>\r\n                        <a target=\"_blank\" href=\"http://acg.gamersky.com/zt/donghua201801/\">18年1月番</a>\r\n                    </div>\r\n                    <div>\r\n                        <a target=\"_blank\" href=\"http://acg.gamersky.com/news/\">动漫资讯</a>\r\n                        <a target=\"_blank\" href=\"http://acg.gamersky.com/otaku/zb/\">动漫周边</a>\r\n                        <a target=\"_blank\" href=\"http://acg.gamersky.com/music/\">动漫音乐</a>\r\n                    </div>\r\n                </div>\r\n            </li>\r\n            <li>\r\n                <div class=\"tit\">其他综合</div>\r\n                <div class=\"like\">\r\n                    <div>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/wenku/\">杂谈文库</a>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/hardware/\">游戏硬件</a>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/zl/academy/\">讲武堂</a>\r\n\r\n            </div>\r\n            <div>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/ent/\">休闲娱乐</a>\r\n                <a target=\"_blank\" href=\"http://www.gamersky.com/tech/\">趣味科技</a>\r\n                <a target=\"_blank\" href=\"http://i.gamersky.com/club/2\">游民圈子</a>\r\n\r\n            </div>\r\n                </div>\r\n            </li>\r\n        </ul>\r\n    </div>\r\n</div>\r\n</div>\r\n</body>\r\n</html>',1,1513333330,1514628928),(2,'测试分类','testlist','<!DOCTYPE HTML>\r\n<html>\r\n<head>\r\n<meta charset=\"UTF-8\">\r\n<title>{$category.title}_{$title}7777777777777777</title>\r\n<meta name=\"Keywords\" content=\"\">\r\n<meta name=\"Description\" content=\"\">\r\n<link href=\"/Public/static/bootstrap/css/bootstrap.css\" rel=\"stylesheet\">\r\n<link href=\"/Public/static/bootstrap/css/bootstrap-responsive.css\" rel=\"stylesheet\">\r\n<link href=\"/Public/static/bootstrap/css/docs.css\" rel=\"stylesheet\">\r\n<link href=\"/Public/static/bootstrap/css/onethink.css\" rel=\"stylesheet\">\r\n<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->\r\n<!--[if lt IE 9]>\r\n<script src=\"/Public/static/bootstrap/js/html5shiv.js\"></script>\r\n<![endif]-->\r\n<!--[if lt IE 9]>\r\n<script type=\"text/javascript\" src=\"/Public/static/jquery-1.10.2.min.js\"></script>\r\n<![endif]-->\r\n<!--[if gte IE 9]><!-->\r\n<script type=\"text/javascript\" src=\"/Public/static/jquery-2.0.3.min.js\"></script>\r\n<script type=\"text/javascript\" src=\"/Public/static/bootstrap/js/bootstrap.min.js\"></script>\r\n<!--<![endif]-->\r\n</head>\r\n<body>\r\n<div class=\"navbar navbar-inverse navbar-fixed-top\">\r\n    <div class=\"navbar-inner\">\r\n        <div class=\"container\">\r\n            <a class=\"brand\" href=\"/\">{$title}</a>\r\n            <div class=\"nav-collapse collapse\">\r\n                <ul class=\"nav\">\r\n                        <li>\r\n                            <a href=\"/\">首页</a>\r\n                        </li>\r\n					<volist name=\"catelist\" id=\"vo\">\r\n                        <li>\r\n                            <a href=\"/{$vo.name}\">{$vo.title}</a>\r\n                        </li>\r\n					</volist>\r\n                </ul>\r\n            </div>\r\n        </div>\r\n    </div>\r\n</div>\r\n\r\n<header class=\"jumbotron subhead\" id=\"overview\">\r\n	<div class=\"container\">\r\n		<h2>{$category.title}</h2>\r\n		<p class=\"lead\"></p>\r\n	</div>\r\n</header>\r\n<div class=\"container\">\r\n	<div class=\"crumbs\">{$breadcrumbs}</div>\r\n    <div class=\"row\">\r\n            <div class=\"span3 bs-docs-sidebar\">\r\n                <ul class=\"nav nav-list bs-docs-sidenav\">\r\n					<volist name=\"currentcate\" id=\"vo\">\r\n						<li <eq name=\'vo.id\' value=\"$category[\'id\']\">class=\"active\"</eq>><a href=\"{$vo.link}\">{$vo.title}</a></li>\r\n					</volist>\r\n                </ul>\r\n            </div>\r\n			<div class=\"span9\">\r\n				<section id=\"contents\">\r\n					<volist name=\"list\" id=\"data\">\r\n						<div class=\"\">\r\n							<h3 class=\"ellipsis\"><a href=\"/article/detail/{$data[\'id\']}.html  \">{$data.title}</a></h3>\r\n						</div>\r\n						<div>\r\n							<p class=\"lead\">{$data.description}</p>\r\n						</div>\r\n						<div>\r\n							<span><a href=\"/article/detail/{$data[\'id\']}.html\">查看全文</a></span>\r\n							<span class=\"pull-right\">\r\n								<span>发表于 {$data.create_time|date=\'Y-m-d\',###}</span>\r\n							</span>\r\n						</div>\r\n						<hr/>\r\n					</volist>			\r\n					<div class=\"onethink pagination pagination-right pagination-large\">\r\n						{$page}\r\n					</div>\r\n				</section>\r\n			</div>\r\n    </div>\r\n</div>\r\n</body>\r\n</html>',1,1514739702,1514740624);

DROP TABLE IF EXISTS `ot_ucenter_admin`;

CREATE TABLE `ot_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';


DROP TABLE IF EXISTS `ot_ucenter_app`;

CREATE TABLE `ot_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL DEFAULT '' COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL DEFAULT '' COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

DROP TABLE IF EXISTS `ot_ucenter_member`;

CREATE TABLE `ot_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';


INSERT INTO `ot_ucenter_member` VALUES (1,'Administrator','f1dd57c8ee4d6c121fc31e3a5381b869','admin@admin.com','',1536404009,2130706433,1537184497,2130706433,1536404009,1);


DROP TABLE IF EXISTS `ot_ucenter_setting`;

CREATE TABLE `ot_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';


DROP TABLE IF EXISTS `ot_url`;

CREATE TABLE `ot_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';


DROP TABLE IF EXISTS `ot_userdata`;

CREATE TABLE `ot_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ot_yuming`;

CREATE TABLE `ot_yuming` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` varchar(10000) NOT NULL DEFAULT '' COMMENT '链接地址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='链接表';

INSERT INTO `ot_yuming` VALUES (1,'www.lfxinyueyang.com====\nwww.kanjuwang.com====\nhttp://www.direct-wholesaler.com====\nhttp://www.kfylkj.com====',1,1536846877);
