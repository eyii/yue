<template>
    <div>
        <el-table :data="$store.getters.getUsers" highlight-current-row @selection-change="sels=$event.target.value" >
            <el-table-column v-for="(item,key) in options" :key="key" :label="item.text" :prop="item.value"  v-if="item.show"  :width="item.width" >
                <ecol slot-scope="scope" :keyname="item.value" :row="scope.row" :item="item">
                    <span slot="common">{{scope.row[item.value]}}</span>
                 <!--  <span slot="state">  {{ ['完成','申请','已取消','已支付','已失败','已删除'][scope.row.state] }}</span>-->
             <!--     <span slot="actionTime">{{moment.unix(scope.row.actionTime).format("YYYY-MM-DD HH:mm:ss")  }}</span>-->
                    <span slot="op" >
                         <el-button size="small" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button type="danger" size="small" @click="handleDel(scope.$index, scope.row)">删除</el-button>
                     </span>
                </ecol>
            </el-table-column>
        </el-table>

    </div>
</template>

<script>

    import { getUserListPage, removeUser } from '@/api/api';
    import ecol from '@/components/eleme/table/ecol'
    export default {
        name: "elist",
        components: {ecol},

        props: {
            value:{ type:Boolean, default:false},
        },
        data() {
            return {
                page: 1,
                users:[],
                sels: [],
                editLoading: false,
                editForm: { id: 0, name: '', sex: -1, age: 0, birth: '', addr: ''},
                addLoading: false,
                options: [
                    {value: 'id',               text: 'id',           disabled:true,   show:true, width:120,copy:false},
                    {value: 'name',             text: '会员账号',       disabled:true,    show:true, width:120,copy:false},
                    {value: 'address',            text: '地址',         disabled:true,  show:true, width:300,copy:false} ,
                    {value: 'op',               text: '操作',         disabled:true,    show:true, width:300,copy:false} ,
                    {value: 'actionTime',       text: '申请时间',      disabled:true,   show:true,  width:120,copy:false} ,
                ],
            }
        },

        methods: {

            handleEdit: function (index, row) {
                this.$emit('input', true);

                this.editForm = Object.assign({}, row);
            },


        },


    }
</script>

<style scoped>

</style>