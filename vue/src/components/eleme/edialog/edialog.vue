<template>
    <el-dialog :title="value.title" :visible.sync="value.isShow" width="30%" >
        <el-table :data="value.bl">
            <el-table-column property="A" label="累计有效投注" width="150"></el-table-column>
            <el-table-column property="B" label="可获奖金" width="200"></el-table-column>

        </el-table>
        <span slot="footer" class="dialog-footer">
            <el-button @click="show">取 消</el-button>
             <el-button type="primary" @click="show" >确 定</el-button>
        </span>
    </el-dialog>
</template>

<script>
    export default {
        name: "edialog",
        props: {
            value:{
                isShow:false,
                title:'编辑',
                list:[],
                bl:[],
            }
        },
        methods:{
            show(){
               this.value.isShow=false;
               this.$emit('input',this.value);
            }
        }


    }
</script>

<style scoped>

</style>


