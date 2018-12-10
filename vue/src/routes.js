import Login from './views/Login.vue'
import NotFound from './views/404.vue'
import Home from './views/Home.vue'
import Main from './views/Main.vue'
import Table from './views/nav1/Table.vue'
import otable from './views/nav1/otable'
import user from './views/nav1/user.vue'
import Page4 from './views/nav2/Page4.vue'
import Page5 from './views/nav2/Page5.vue'
import echarts from './views/charts/echarts.vue'

let routes = [
    {path: '/login', component: Login, name: '', hidden: true},
    {path: '/404', component: NotFound, name: '', hidden: true},
    {path: '/', component: Home, name: '导航一', iconCls: 'el-icon-message', children: [
            { path: '/main', component: Main, name: '主页', hidden: true },
            { path: '/table', component: Table, name: '返佣' },
            { path: '/user', component: user, name: '列表' },
            { path: '/otable', component: otable, name: '列表2' },
        ]},
    {path: '/', component: Home, name: '导航二', iconCls: 'fa fa-id-card-o', children: [
            { path: '/page4', component: Page4, name: '页面4' },
            { path: '/page5', component: Page5, name: '页面5' }
        ]},
    {path: '/', component: Home, name: 'Charts', iconCls: 'fa fa-bar-chart', children: [
            { path: '/echarts', component: echarts, name: 'echarts' }
        ]},
    {path: '*', hidden: true, redirect: { path: '/404' }}
];

export default routes;