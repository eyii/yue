<template>
    <el-button  :size="size" :type="type"  @click="$emit('click')" >{{title}}</el-button>
</template>

<script>


    export default {
        name: "btnGreen",
        props:{
            title:{default:'按钮', type:String,},
            type:{type:String, default:'success'},
            size:{type:String, default:'mini'}
        },

    }
</script>

