<template>
    <el-upload action="" :on-change="handleChange" :httpRequest="uploadFile">
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>
    </el-upload>


</template>
<script>
    export default {
        data() {
            return {
                file: {},
                url:'http://f.cn/v1/upload/upload/?XDEBUG_SESSION_START=12983'
            };
        },
        methods: {
            handleChange(file) {
                debugger;
                this.file = file.raw
            },

            uploadFile() {
                debugger;


                event.preventDefault();
                let form = new FormData();
                form.append("UploadForm[file]",this.file);



           //     let config = {headers: {'Content-Type': 'multipart/form-data'}};

                this.$http.post(this.url, form);


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