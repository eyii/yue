<template>
    <el-upload action="" :on-change="handleChange" :httpRequest="uploadFile">
     <el-button  type="primary">上传</el-button>
    </el-upload>


</template>
<script>
   import VPost from '../../../components/js/ajax/VPost'

    export default {
        name:'excel',
        props:{
            value:{}
        },
        data() {
            return {
                file: {},

                form:{
                    url:'http://f.cn/v1/upload/upload',
                    param:{},
                    success:this.success,
                    catch:'上传失败'
                }
            };
        },
        methods: {
            success(msg,data){
                data=this.toArray(data);
                data.shift();
                this.$emit('input', data);
              //  alert(msg);
            },
            handleChange(file) {

                this.file = file.raw
            },

            uploadFile() {
                this.form.param= new FormData();
                this.form.param.append('UploadForm[file]',this.file);
                new VPost(this.form,this);

            }

        }
    }
</script>
<style scope>
    input[type="file"] {display: none;}
    .el-upload-list{width: 200px;}
    .el-select {width: 135px;}
</style>