<template>
  <div>
      <el-table :data="$store.getters.getUsers" highlight-current-row @selection-change="sels=$event.target.value" style="width: 100%;">
          <el-table-column type="selection" width="55"></el-table-column>
          <el-table-column type="index" width="60"></el-table-column>
          <el-table-column label="操作" width="150">
              <template slot-scope="scope">
                  <el-button size="small" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                  <el-button type="danger" size="small" @click="handleDel(scope.$index, scope.row)">删除</el-button>
              </template>
          </el-table-column>
      </el-table>

  </div>
</template>

<script>

    import { getUserListPage, removeUser } from '../../../api/api';
    export default {
        name: "elist",
        props: {
            showDialog:{
                type:Boolean,
                default:false
            }

        },

        data() {
            return {
                filters: { name: ''},
                total: 0,
                page: 1,
                users:[],
                sels: [],//列表选中列
                showDialog:this.showDialog,//编辑界面是否显示
                editLoading: false,
                editForm: { id: 0, name: '', sex: -1, age: 0, birth: '', addr: ''},
                addFormVisible: false,                                                      //新增界面是否显示
                addLoading: false,
                addForm: {name: '', sex: -1, age: 0, birth: '', addr: ''}                   //新page增界面数据

            }
        },


        methods: {
            getUsers() {
                let para = {page: this.page, name: this.filters.name};
                getUserListPage(para).then((res) => {
                    this.total = res.data.total;
                    this.commit('setUsers',res.data.users);

                });
            },
            handleEdit: function (index, row) {
                this.showDialog = true;
                this.editForm = Object.assign({}, row);
            },


        },
        watch:{
            showDialog(val){ this.$emit('update:showDialog', val); },
        },

        mounted() {
           this.getUsers();
        }
    }
</script>

<style scoped>

</style>