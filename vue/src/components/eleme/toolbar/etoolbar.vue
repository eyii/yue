<template>
    <el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
        <el-form :inline="true" >
            <el-form-item><el-input v-model="value.name" placeholder="姓名"></el-input></el-form-item>
            <el-form-item><el-button type="primary" v-on:click="value.fcheck">查询</el-button></el-form-item>
            <el-form-item><el-button type="primary" @click="value.fadd">新增</el-button></el-form-item>
            <el-form-item style="float: right;"><el-button type="primary" @click="value.fexport">导出</el-button></el-form-item>
        </el-form>
    </el-col>
</template>

<script>
    export default {
        name: "etoolbar",
        props:{
            value:{
                name:'ddd',
                fcheck:'',
                fadd:'',
                fexport:'',
            }
        }

    }
</script>

