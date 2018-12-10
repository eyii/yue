<template>
    <el-dialog title="编辑" :visible.sync="value" width="30%" :before-close="show">
         <div> <span slot="content"> 这是一段信息</span></div>
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
            value:{type:Boolean, default:false}
        },
        methods:{
            show(){
               this.$emit('input',false);
            }
        }


    }
</script>

<style scoped>

</style>


