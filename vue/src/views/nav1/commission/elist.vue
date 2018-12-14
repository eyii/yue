<template>
    <div>
        <el-table :data="value.list"  highlight-current-row  >
            <el-table-column height="20" v-for="(item,key) in options"  :key="key" :label="item.text" :prop="item.value"  v-if="item.show"   :width="item.width" >
                <ecol slot-scope="scope" :ekey="item.value" v-model="editf" :index="scope.$index">

                    <span slot="common">{{scope.row[item.value]}}</span>
                    <span slot="other"> <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="A">     <el-input  size="small"  v-model="scope.row[item.value]" /></span>
                    <span slot="E" >    <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="F" >
                        <el-button  size="mini"   v-show="!editf.other"   @click="editf.other=true;editf.row=scope.$index">编辑</el-button>
                        <el-button  size="mini"   v-show="!editf.other"  type="danger"  @click="del(scope.$index)">删除</el-button>
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
                    {value: 'A',               text: '比例',           disabled:true,     show:true,    width:100, copy:false},
                    {value: 'B',               text: '关卡',           disabled:true,     show:true,   width:150, copy:false},
                    {value: 'C',               text: '会员',           disabled:true,     show:true,   width:100,copy:false} ,
                    {value: 'D',               text: '金额',           disabled:true,     show:true,   width:150,copy:false} ,
                    {value: 'E',               text: '结果',           disabled:true,     show:true,    width:150,copy:false} ,
                    {value: 'F',              text: '操作',            disabled:true,     show:true,    width:150,copy:false} ,
                ],
                editf:{
                    other:false,
                    row:0,
                    col:0,
                    op:'F'
                }
            }
        },

        methods: {

            del(index){
                this.value.list.splice(index, 1);
            }

        },


    }
</script>

<style scoped>

</style>