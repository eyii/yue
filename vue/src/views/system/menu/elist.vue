<template>
    <div>
        <el-table :data="value.list"  highlight-current-row  border  show-summary >
            <el-table-column height="20" v-for="(item,key) in options"  :key="key" :label="item.text" :prop="item.value"  v-if="item.show"   :width="item.width" >
                <ecol slot-scope="scope" :ekey="item.value" v-model="editf" :index="scope.$index">
                    <span slot="common">{{scope.row[item.value]}}</span>
                    <span slot="other"> <el-input  size="small"   v-model="scope.row[item.value]" /></span>
                    <span slot="op" >
                        <btnBlue    v-show="!editf.other" @click="editf.other=true;editf.row=scope.$index" title="编辑" />
                        <el-button  size="mini"   v-show="!editf.other"   type="danger"  @click="del(scope)">删除</el-button>
                        <el-button  size="mini"   v-show="editf.other"    type="danger"   @click="edit(scope.row)">确定</el-button>
                    </span>

                </ecol>
            </el-table-column>
        </el-table>

    </div>
</template>

<script>

    import {setMenu,getMenus,delMenu,addMenu} from '../../../api/api';
    import btnBlue from '../../../components/eleme/button/btnBlue'
    import ecol from '../../../components/eleme/table/ecol'
    import {items} from './option'
    export default {
        name: "elist",
        components: {ecol,btnBlue},
        props: {
            value:{ isShow:false, list:[], editForm: {},},
        },
        data() {
            return {
                options: items,
                editf:{other:false, row:0, col:0, op:'op'},
                form:{
                    del:{ index:'', param:{}, success:this.dsuccess,catch:this.catch},
                    add:{param:{path:'',parent:'',component:'',name:'',icon:'',hidden:0,redirect:''}, success:'更新成功',catch:this.catch},
                    patch:{param:{}, success:'更新成功',catch:this.catch},
                    view:{param:{}, success:this.success,catch:this.catch},
                }
            }
        },
        methods:{
            edit(row){
                this.form.patch.param=row;
                setMenu(row.id,this.form.patch,this);
                this.editf.other=false;
            },
            catch(msg,data){
                this.$message({message: msg, type: 'error'});
            },
            success(msg,data){
              this.value.list=data;
            },
            dsuccess(msg,data){
                this.value.list.splice(this.form.del.index,1);
                this.$message({message: msg, type: 'error'});
            },
            del(scope){
                this.form.del.index=scope.$index;
                delMenu(scope.row.id,this.form.del,this);
            },

        },
        created(){
            getMenus(this.form.view,this);
        },



    }
</script>

<style scoped>

</style>