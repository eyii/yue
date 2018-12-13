<template>
    <div>
        <el-table :data="value.list" highlight-current-row   >
            <el-table-column height="20" v-for="(item,key) in options"  :key="key" :label="item.text" :prop="item.value"  v-if="item.show"   :width="item.width" >
                <ecol slot-scope="scope" :keyname="item.value" :row="scope.row" :item="item" >

                    <span slot="common">{{scope.row[item.value]}}</span>
                    <span slot="A"><el-input v-model="scope.row[item.value]" /></span>
                    <span slot="E" > <input ref="cols"  :value="imgWD(scope.row)" /></span>
                    <span slot="F" > <el-button size="small" @click="edit(scope.$index, scope.row)">编辑</el-button> </span>
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
            value:{
                isShow:false,
                list:[],
                editForm: {},
            },
        },
        data() {
            return {

                options: [
                    {value: 'A',               text: '比例',               disabled:true,     show:true,    width:150, copy:false},
                    {value: 'B',               text: '关卡',         disabled:true,     show:true,   width:150, copy:false},
                    {value: 'C',               text: '会员',             disabled:true,     show:true,   width:150,copy:false} ,
                    {value: 'D',               text: '投注',              disabled:true,     show:true,   width:150,copy:false} ,
                    {value: 'E',               text: '结果',             disabled:true,    show:true,  width:150,copy:false} ,
                    {value: 'F',              text: '操作',             disabled:true,    show:true,  width:150,copy:false} ,
                ],
            }
        },

        methods: {
            edit: function (index, row) {
                    debugger;
                let cols=this.getByKey(this.$refs.cols,'value','E');
                this.addCol(this.value.list,cols);
                this.value.isShow=true;
                this.value.editForm = Object.assign({}, row);
                this.$emit('input', this.value);
            },
            change(e,v,t){
                debugger;
                console.log(v,t)
            }

        },

        watch:{
            'value.list'(val){
               this.addCol(this.value.list,null);
            },

        },
        computed:{
            imgWD(){
                return row=> {
                    return row['A']*row['D'];
                }
            }
        }



    }
</script>

<style scoped>

</style>