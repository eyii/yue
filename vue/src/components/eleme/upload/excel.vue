<template>
    <el-upload action="" :on-change="handleChange" :httpRequest="uploadFile">
     <el-button  type="primary">上传</el-button>
    </el-upload>


</template>
<script>
   import VPost from '@/components/js/ajax/VPost'

    export default {
        data() {
            return {
                file: {},

                form:{
                    url:'http://f.cn/v1/upload/upload?XDEBUG_SESSION_START=11886',
                    param:{},
                    success:this.success,
                    catch:this.catch
                }
            };
        },
        methods: {
            success(msg,data){
                alert(msg);
            },
            catch(msg,data){
                alert(msg);

            },
            handleChange(file) {

                this.file = file.raw
            },

            uploadFile() {
                this.form.param= new FormData();
                this.form.param.append('UploadForm[file]',this.file);
                new VPost(this.form,this,true);

            }

        }
    }
</script>
<style scope>
    input[type="file"] {
        display: none;
    }
    .el-upload-list{
        width: 200px;
    }
    .el-select {
        width: 135px;
    }

</style>