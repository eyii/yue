<template>
    <div>
        <el-table :data="value.list"  highlight-current-row  border  show-summary >
            <el-table-column height="20" v-for="(item,key) in options"  :key="key" :label="item.text" :prop="item.value"  v-if="item.show"   :width="item.width" >
                <ecol slot-scope="scope" :ekey="item.value" v-model="editf" :index="scope.$index">

                    <span slot="common">{{scope.row[item.value]}}</span>
                    <span slot="other"> <el-input  size="small"   v-model="scope.row[item.value]" /></span>

                    <span slot="op" >
                        <el-button  size="mini"   v-show="!editf.other"   @click="editf.other=true;editf.row=scope.$index">编辑</el-button>
                        <el-button  size="mini"   v-show="!editf.other"   type="danger"  @click="value.list.splice(scope.$index, 1)">删除</el-button>
                        <el-button  size="mini"   v-show="editf.other"    type="danger"   @click="edit(scope.$index,scope.row)">确定</el-button>
                    </span>

                </ecol>
            </el-table-column>
        </el-table>

    </div>
</template>

<script>

    import { getUserListPage, removeUser } from '@/api/api';
    import ecol from '../../../components/eleme/table/ecol'
    export default {
        name: "elist",
        components: {ecol},
        props: {
            value:{ isShow:false, list:[], editForm: {},},
        },
        data() {
            return {
                options: [
                    {value: 'path',                 text: '地址',              disabled:true,     show:true,   width:100,copy:false} ,
                    {value: 'parent',               text: '上级菜单',           disabled:true,     show:true,   width:150,copy:false} ,
                    {value: 'component',            text: '组件',              disabled:true,     show:true,    width:150,copy:false} ,
                    {value: 'name',                 text: '菜单名',            disabled:true,     show:true,    width:150,copy:false} ,
                    {value: 'icon',                 text: '图标',              disabled:true,     show:true,    width:150,copy:false} ,
                    {value: 'hidden',               text: '隐藏',              disabled:true,     show:true,    width:150,copy:false} ,
                    {value: 'redirect',             text: '重定向',            disabled:true,     show:true,    width:150,copy:false} ,
                    {value: 'op',             text: '重定向',            disabled:true,     show:true,    width:150,copy:false} ,
                ],
                editf:{
                    other:false,
                    row:0,
                    col:0,
                    op:'op'
                },
                delForm:{
                    url:'',
                    param:{

                    }
                },
                addForm:{
                    url:'',
                    param:{

                    }
                },
                viewForm:{
                    url:'',
                    param:{

                    }
                },
            }
        },
        methods:{
            edit(index,row){
                this.editf.other=false;

            }
        }



    }
</script>

<style scoped>

</style>