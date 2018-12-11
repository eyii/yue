<template>
    <el-upload class="upload-demo"  :on-success='handleSuccess' show-file-list drag action="http://f.cn/v1/upload/upload" multiple>
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>

    </el-upload>
</template>

<script>
    export default {
        name: "excel",
        methods:{
            handleSuccess(res,file,fileList){
             this.$message(res.code===20000?{message: '上传成功！', type: 'success'}:
                 {message: res.msg, type: 'error'});

            },

        }
    }
</script>

<style scoped>

</style>