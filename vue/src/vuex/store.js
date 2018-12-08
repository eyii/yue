import Vue from 'vue'
import Vuex from 'vuex'
import * as actions from './actions'
import * as getters from './getters'

Vue.use(Vuex);

// 应用初始状态
const state = {
    filters: { name: ''},
    total: 0,
    users:[],
    page: 1,
    listLoading: false,
    sels: [],//列表选中列
   // editFormVisible: false,//编辑界面是否显示
    editLoading: false,
    editForm: { id: 0, name: '', sex: -1, age: 0, birth: '', addr: ''},
    addFormVisible: false,                                                      //新增界面是否显示
    addLoading: false,
    addForm: {name: '', sex: -1, age: 0, birth: '', addr: ''}                   //新page增界面数据

}

// 定义所需的 mutations
const mutations = {
    INCREMENT(state) {
        state.count++
    },
    DECREMENT(state) {
        state.count--
    },
    setUsers(state,users){
        state.users=users
    } ,
}

// 创建 store 实例
export default new Vuex.Store({
    actions,
    getters,
    state,
    mutations
})