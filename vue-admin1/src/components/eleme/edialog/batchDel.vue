<template>
    <el-col :span="24" class="toolbar">
        <el-button type="danger" @click="batchRemove" :disabled="this.sels.length===0">批量删除</el-button>
        <el-pagination layout="prev, pager, next" @current-change="handleCurrentChange" :page-size="20" :total="total" style="float:right;">
        </el-pagination>
    </el-col>
</template>

<script>
    export default {
        name: "batchDel"
    }
</script>

<style scoped>

</style>