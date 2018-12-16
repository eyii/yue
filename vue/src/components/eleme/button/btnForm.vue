<template>
    <el-form-item><el-button :type="type"  v-on:click="$emit('click')">{{title}}</el-button></el-form-item>
</template>

<script>

    export default {
        name: "btnForm",
        props: {
            title:  {default: ''},
            type: {type:String, default:'primary',}
        },

    }
</script>

<!--
/*<ebutton
        @click="save(urls.add,'add')" title="新增" offset="4"/>*/
-->


<style scoped>

</style>