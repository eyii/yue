<template>
    <div>
        <el-table :data="value.list"  highlight-current-row  border  show-summary >
            <el-table-column height="20" v-for="(item,key) in options"  :key="key" :label="item.text" :prop="item.value"  v-if="item.show"   :width="item.width" >
                <ecol slot-scope="scope" :ekey="item.value" v-model="editf" :index="scope.$index">

                    <span slot="common">{{scope.row[item.value]}}</span>
                    <span slot="other"> <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="C" >    <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="D" >
                        <el-button  size="mini"   v-show="!editf.other"   @click="editf.other=true;editf.row=scope.$index">编辑</el-button>
                        <el-button  size="mini"   v-show="!editf.other"  type="danger"  @click="value.list.splice(scope.$index, 1)">删除</el-button>
                        <el-button  size="mini"   v-show="editf.other"  type="danger"   @click="editf.other=false">确定</el-button>
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
                    {value: 'A',               text: '会员账号',           disabled:true,     show:true,   width:100,copy:false} ,
                    {value: 'B',               text: '有效投注',           disabled:true,     show:true,   width:150,copy:false} ,
                    {value: 'C',               text: '结果',           disabled:true,     show:true,    width:150,copy:false} ,
                    {value: 'D',              text: '操作',            disabled:true,     show:true,    width:150,copy:false} ,
                ],
                editf:{
                    other:false,
                    row:0,
                    col:0,
                    op:'D'
                }
            }
        },



    }
</script>

<style scoped>

</style>