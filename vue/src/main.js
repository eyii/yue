import babelpolyfill from 'babel-polyfill'
import Vue from 'vue'
import App from './App'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-default/index.css'
//import './assets/theme/theme-green/index.css'
import VueRouter from 'vue-router'
import store from './vuex/store'
import Vuex from 'vuex'
import routes from './routes'

import 'font-awesome/css/font-awesome.min.css'
//import  VueResource  from  'vue-resource';
import  '@/components/func/func'
import func from './components/func/func'
//js
import axios from 'axios'
Vue.prototype.$http = axios;
Vue.prototype.xdebugger='?XDEBUG_SESSION_START=12885'
//Vue.prototype.xdebugger=''

import '@/components/js/Array'
Vue.use(func);
import vreq from 'vreq'
Vue.use(vreq)

//Vue.use(VueResource);
Vue.use(ElementUI);
Vue.use(VueRouter);
Vue.use(Vuex);

const router = new VueRouter({routes})
router.beforeEach((to, from, next) => {
    if (to.path == '/login') sessionStorage.removeItem('user');
    let user = JSON.parse(sessionStorage.getItem('user'));
    (!user && to.path != '/login')? next({ path: '/login' }):next()

})

new Vue({router, store, render: h => h(App)}).$mount('#app')

