<template>
    <el-form-item style="float: right;">
            <el-upload ref="upload" action="" drag :on-change="({raw}) => file = raw" :httpRequest="uploadFile"   :multiple='false'>
              <el-button  type="primary">{{title}}</el-button>
            </el-upload>
    </el-form-item>

</template>
<script>


    export default {
        name:'uploadexcel',
        props:{
            value:{

            },
            title:'',
            url:"",

            filename:'',
            autoread:false
        },
        data() {
            return {
                file: {},
                form:{
                    url:this.url,
                    param:{},
                    success:this.success,
                    catch:false
                }
            };
        },
        methods: {
            success(msg,data){

                data=this.toArray(data);
                data.shift();
                this.$emit('input', data);
            },

            uploadFile(hasFile=true) {

                this.form.param= new FormData();
               if (hasFile) this.form.param.append('UploadForm[file]',this.file);
                this.form.param.append('filename',this.$route.path+'_'+this.filename);
                new VPost(this.form,this);
                if (hasFile)    this.$refs.upload.clearFiles();
            }

        },
        created(){
         if (this.autoread) this.uploadFile(false)
        }
    }
</script>





<style>
    input[type="file"] {display: none;}
    .el-upload-list{width: 0px;}
    .el-select {width: 135px;}
    .el-upload-dragger {
        width: 100px;
        height: 36px;

    }
</style>