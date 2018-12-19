import Login from './views/user/login'
import Reg from './views/user/reg'
import NotFound from './views/404.vue'
import Home from './views/home/index'
import Commission from './views/nav1/commission/index'
import loss from './views/nav1/loss/index'

import menuManage from './views/system/menu/index.vue'


let routes = [
    {path: '/login', component: Login, name: '登录', hidden: true},
    {path: '/reg', component: Reg, name: '注册', hidden: true},
    {path: '/', component: Home, name: '财务', icon: 'el-icon-message', children: [
            { path: '/Commission', component: Commission, name: '增益' },
            { path: '/loss', component: loss, name: '损益' },
        ]},
    {path: '/', component: Home, name: '系统', icon: 'fa fa-id-card-o', children: [
           { path: '/menuManage', component: menuManage, name: '菜单管理' },
        ]},
    {path: '/404', component: NotFound, name: '', hidden: true},
    {path: '*', hidden: true, redirect: { path: '/404' }}
];
//{ path: '/main', component: Main, name: '主页', hidden: true },
export default routes;