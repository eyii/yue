<template>
    <el-dialog :title="value.title" :visible.sync="value.isShow" width="30%" >
         <div> <span slot="content"> {{value.editForm}}</span></div>
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
                title:'编辑'
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


