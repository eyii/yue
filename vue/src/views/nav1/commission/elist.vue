<template>
    <div>
        <el-table :data="value.list"  highlight-current-row  border  show-summary >
            <el-table-column height="20" v-for="(item,key) in options"  :key="key" :label="item.text" :prop="item.value"  v-if="item.show"   :width="item.width" >
                <ecol slot-scope="scope" :ekey="item.value" v-model="colForm" :index="scope.$index">

                    <span slot="common">{{scope.row[item.value]}}</span>
                    <span slot="other"> <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="C" >    <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="D" >
                        <el-button  size="mini"   v-show="! colForm.other"   @click=" colForm.other=true; colForm.row=scope.$index">编辑</el-button>
                        <el-button  size="mini"   v-show="! colForm.other"  type="danger"  @click="value.list.splice(scope.$index, 1)">删除</el-button>
                        <el-button  size="mini"   v-show="colForm.other"  type="danger"   @click=" colForm.other=false">确定</el-button>
                    </span>

                </ecol>
            </el-table-column>
        </el-table>

    </div>
</template>

<script>

    import { getUserListPage, removeUser } from '@/api/api';
    import ecol from '../../../components/eleme/table/ecol'
    import {options,colForm} from './option'
    export default {
        name: "elist",
        components: {ecol},
        props: {value:{ isShow:false, list:[], editForm: {},},},
        data() {
           let result=  {options, colForm};
            return result
        },



    }
</script>

<style scoped>

</style>