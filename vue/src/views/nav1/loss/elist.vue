<template>
    <div>
        <el-table :data="value.list"  highlight-current-row  border  show-summary >
            <el-table-column height="20" v-for="(item,key) in options"  :key="key" :label="item.text" :prop="item.value"  v-if="item.show"   :width="item.width" >
                <ecol slot-scope="scope" :ekey="item.value" v-model="editf" :index="scope.$index">

                    <span slot="common">{{scope.row[item.value]}}</span>
                    <span slot="other"> <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="C" >    <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="D" >
                         <btnBlue   v-show="!editf.other" @click="editf.other=true;editf.row=scope.$index" title="编辑" />

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
    import btnBlue from '@/components/eleme/button/btnBlue'
    import {option} from './option'
    export default {
        name: "elist",
        components: {ecol,btnBlue},
        props: {
            value:{ isShow:false, list:[], editForm: {},},
        },
        data() {
            return {
                options: option,
                editf:{other:false, row:0, col:0, op:'D'}
            }
        },



    }
</script>

<style scoped>

</style>