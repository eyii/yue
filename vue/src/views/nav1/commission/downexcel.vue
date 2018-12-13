<template>
    <excel class="btn btn-default" :data= "value.list" :fields= "value.fields" :name= "file">  <el-button  type="primary">导出</el-button></excel>
</template>

<script>
    import excel from 'vue-json-excel'
    export default {
        name: "downexcel",
        components:{excel},
        props:{
            value:{
                list:[],
                fields:{},

            },
            file:'数据.xls'
        }
    }
</script>

<style scoped>

</style>