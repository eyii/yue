<template>
    <el-col :span="24" class="toolbar">
        <el-button type="danger" @click="batchRemove" :disabled="this.sels.length===0">批量删除</el-button>
        <el-pagination layout="prev, pager, next" @current-change="handleCurrentChange" :page-size="20" :total="total" style="float:right;">
        </el-pagination>
    </el-col>
</template>

<script>
    export default {
        name: "batchDel",
        data() {
            return {
                filters: { name: ''},
                total: 0,
                page: 1,
                listLoading: false,
                sels: [],//列表选中列
                editFormVisible: false,//编辑界面是否显示
                editLoading: false,
                editForm: { id: 0, name: '', sex: -1, age: 0, birth: '', addr: ''},
                addFormVisible: false,                                                      //新增界面是否显示
                addLoading: false,
                addForm: {name: '', sex: -1, age: 0, birth: '', addr: ''}                   //新page增界面数据

            }
        },

        /*   computed: {
               users: {
                   get () {
                       return this.$store.state.test
                   },
                   set (val) {
                       this.$store.commit('setUsers', val)
                   }
               }
           },
   */
        methods: {
            formatSex: function (row, column) {
                return row.sex == 1 ? '男' : row.sex == 0 ? '女' : '未知';
            },
            getUsers() {
                let para = {page: this.page, name: this.filters.name};
                this.listLoading = true;
                getUserListPage(para).then((res) => {
                    this.total = res.data.total;
                    this.commit('setUsers',res.data.list);
                    this.listLoading = false;

                });
            },
            //删除
            handleDel: function (index, row) {
                this.$confirm('确认删除该记录吗?', '提示', {type: 'warning'}).then(() => {
                    this.listLoading = true;
                    removeUser({ id: row.id }).then((res) => {
                        this.listLoading = false;
                        this.$message({message: '删除成功', type: 'success'});
                        this.getUsers();
                    });
                });
            },
            //显示编辑界面
            edit: function (index, row) {
                this.editFormVisible = true;
                this.editForm = Object.assign({}, row);
            },
            //显示新增界面
            handleAdd: function () {
                this.addFormVisible = true;
                this.addForm = {name: '', sex: -1, age: 0, birth: '', addr: ''};
            },
            selsChange: function (sels) {this.sels = sels;},

        },
        mounted() {
            this.getUsers();
        }
    }
</script>

<style scoped>

</style>