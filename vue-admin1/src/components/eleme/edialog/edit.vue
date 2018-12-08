<template>
    <el-dialog title="编辑" v-model="editFormVisible" :close-on-click-modal="false">
        <el-form :model="editForm" label-width="80px" :rules="editFormRules" ref="editForm">
            <el-form-item label="姓名" prop="name"><el-input v-model="editForm.name" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="性别">
                <el-radio-group v-model="editForm.sex"><el-radio class="radio" :label="1">男</el-radio><el-radio class="radio" :label="0">女</el-radio></el-radio-group>
            </el-form-item>
            <el-form-item label="年龄"><el-input-number v-model="editForm.age" :min="0" :max="200"></el-input-number></el-form-item>
            <el-form-item label="生日"><el-date-picker type="date" placeholder="选择日期" v-model="editForm.birth"></el-date-picker></el-form-item>
            <el-form-item label="地址"><el-input type="textarea" v-model="editForm.addr"></el-input></el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click.native="editFormVisible = false">取消</el-button>
            <el-button type="primary" @click.native="editSubmit" :loading="editLoading">提交</el-button>
        </div>
    </el-dialog>

</template>

<script>
    export default {
        name: "edialogEdit"
    }
</script>

<style scoped>

</style>