<template>
    <el-upload ref="upload" action="" drag :on-change="({raw}) => file = raw" :httpRequest="uploadFile"   :multiple='false'>
     <el-button  type="primary">上传</el-button>
    </el-upload>


</template>
<script>
   import VPost from '../../../components/js/ajax/VPost'

    export default {
        name:'uploadexcel',
        props:{
            value:{}
        },
        data() {
            return {
                file: {},
                autoUpload:false,
                form:{
                    url:'http://f.cn/v1/upload/upload?XDEBUG_SESSION_START=11886',
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
            },

            uploadFile() {
                this.form.param= new FormData();
                this.form.param.append('UploadForm[file]',this.file);
                new VPost(this.form,this);
                this.$refs.upload.clearFiles();
            }

        }
    }
</script>
<style>
    input[type="file"] {display: none;}
    .el-upload-list{width: 0px;}
    .el-select {width: 135px;}
    .el-upload-dragger {
        width: 60px;
        height: 36px;

    }
</style>