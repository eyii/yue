<template>
    <el-table :data="users" highlight-current-row v-loading="listLoading" @selection-change="selsChange" style="width: 100%;">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column type="index" width="60"></el-table-column>
        <el-table-column prop="name" label="姓名" width="120" sortable></el-table-column>
        <el-table-column prop="sex" label="性别" width="100" :formatter="formatSex" sortable></el-table-column>
        <el-table-column prop="age" label="年龄" width="100" sortable></el-table-column>
        <el-table-column prop="birth" label="生日" width="120" sortable></el-table-column>
        <el-table-column prop="addr" label="地址" min-width="180" sortable></el-table-column>
        <el-table-column label="操作" width="150">
            <template slot-scope="scope">
              <el-button size="small" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                <el-button type="danger" size="small" @click="handleDel(scope.$index, scope.row)">删除</el-button>
            </template>
        </el-table-column>
    </el-table>
</template>

<script>

    import { getUserListPage, removeUser } from '../../../api/api';

    export default {
        name: "elist",
        data() {
            return {
                filters: { name: ''},
                users: [],
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
        methods: {
            formatSex: function (row, column) {
                return row.sex == 1 ? '男' : row.sex == 0 ? '女' : '未知';
            },
            getUsers() {
                let para = {page: this.page, name: this.filters.name};
                this.listLoading = true;
                getUserListPage(para).then((res) => {
                    this.total = res.data.total;
                    this.users = res.data.users;
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
            handleEdit: function (index, row) {
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