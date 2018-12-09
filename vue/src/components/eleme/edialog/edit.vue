<template>

    <el-dialog title="编辑" :visible.sync="value" width="30%" :before-close="show">
        <span>这是一段信息</span>
        <span slot="footer" class="dialog-footer">
    <el-button @click="value = false">取 消</el-button>
    <el-button type="primary" @click="value = false">确 定</el-button>
  </span>
    </el-dialog>
</template>

<script>
    export default {
        name: "edit",
        props: {
            value:{type:Boolean, default:false}
        },
        methods:{
            show(){
              //  $emit('input',false);
               this.value=false;
                return false
            }
        }


    }
</script>

<style scoped>

</style>


