<template>
    <el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
        <el-form :inline="true" >
            <el-form-item><el-input v-model="value.name" placeholder="姓名"></el-input></el-form-item>
            <el-form-item><el-button type="primary" v-on:click="value.fcheck">查询</el-button></el-form-item>
            <el-form-item><el-button type="primary" @click="value.fadd">新增</el-button></el-form-item>
            <el-form-item style="float: right;"> <excel v-model="value.list"/></el-form-item>
            <el-form-item style="float: right;"><downexcel v-model="value"/></el-form-item>
        </el-form>
    </el-col>
</template>

<script>
    import excel  from '../../../components/eleme/upload/excel';
    export default {
        name: "etoolbar",
        components: {excel},
        props:{
            value:{
                name:'ddd',
                fcheck:'',
                fadd:'',
                fexport:'',
                list:{}
            }
        },
       /* watch:{
            value(val){
                this.$emit('input', val);
            }
        }*/

    }
</script>

