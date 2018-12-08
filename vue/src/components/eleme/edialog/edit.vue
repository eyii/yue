<template>
    <el-dialog title="编辑" v-model="showDialog" :close-on-click-modal="false">

    </el-dialog>

</template>

<script>
    export default {
        name: "edit",
        data() {
            return {
                showDialog:this.showDialog,

            }
        },

        props: {
            showDialog:{
                type:Boolean,
                default:false
            }
        },
        watch:{
            showDialog(val){
                this.$emit('update:showDialog', val);
            },
        },


    }
</script>

<style scoped>

</style>