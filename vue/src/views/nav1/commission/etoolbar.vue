<template>
    <el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
        <el-form :inline="true" >
            <el-form-item><el-input v-model="value.name" placeholder="姓名"></el-input></el-form-item>
            <el-form-item><el-button type="primary" v-on:click="value.fcheck">查询</el-button></el-form-item>
            <el-form-item><el-button type="primary" @click="fcount">结算</el-button></el-form-item>
            <el-form-item><el-button type="primary" @click="fclear">清空</el-button></el-form-item>
            <el-form-item style="float: right;"> <uploadexcel v-model="value.list"/></el-form-item>
            <el-form-item style="float: right;"><downexcel v-model="value"/></el-form-item>
        </el-form>
    </el-col>
</template>

<script>
    import uploadexcel  from './uploadexcel';
    import downexcel from './downexcel'
    export default {
        name: "etoolbar",
        components: {uploadexcel,downexcel},
        props:{
            value:{
                name:'ddd',
                fcheck:'',
                fadd:'',
                fcount:'',
                list:{}
            }
        },

        methods:{
            fcheck(){
            },
            fadd(){
                debugger;
                return 1;
            },
            fclear(){
                this.value.list.forEach(item=> {item.E=null;});
            },
            fcount(){
                this.value.list.forEach(item=> {
                   if (item.E!=null)return ;
                    item.E=item.A*item.D;
                })

            }
        }


    }
</script>

