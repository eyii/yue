import Vue from 'vue'
import Vuex from 'vuex'
import * as actions from './actions'
import * as getters from './getters'
import  mutations from './mutations'
Vue.use(Vuex);

// 应用初始状态
const state = {
    count: 10,
    users: [],
    total: 0,
    page: 1,
    listLoading: false,
    sels: [],//列表选中列
}

// 定义所需的 mutations


// 创建 store 实例
export default new Vuex.Store({
    actions,
    getters,
    state,
    mutations
})