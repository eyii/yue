import Login from './views/login/index'
import NotFound from './views/404.vue'
import Home from './views/home/index'
import Main from './views/Main.vue'
import Commission from './views/nav1/commission/index'
import loss from './views/nav1/loss/index'
import otable from './views/old/otable'

import menuManage from './views/system/menu/index.vue'
import test from './views/old/test'

let routes = [
    {path: '/login', component: Login, name: '', hidden: true},

    {path: '/', component: Home, name: '财务', icon: 'el-icon-message', children: [
            { path: '/main', component: Main, name: '主页', hidden: true },
            { path: '/Commission', component: Commission, name: '增益' },
            { path: '/loss', component: loss, name: '损益' },
        ]},
    {path: '/', component: Home, name: '系统', icon: 'fa fa-id-card-o', children: [
            { path: '/menuManage', component: menuManage, name: '菜单管理' },
            { path: '/otable', component: otable, name: '列表2' },
            { path: '/test', component: test, name: 'test' },
        ]},
    {path: '/404', component: NotFound, name: '', hidden: true},
    {path: '*', hidden: true, redirect: { path: '/404' }}
];

export default routes;