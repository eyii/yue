<template>
    <el-dialog :title="value.title" :visible.sync="value.isShow" width="30%" >
        <slot> </slot>
        <span slot="footer" class="dialog-footer">
            <el-button @click="value.isShow=false">取 消</el-button>
             <el-button type="primary" @click="value.fshow" >确 定</el-button>
        </span>
    </el-dialog>
</template>

<script>
    export default {
        name: "edialog",
        props: {value:{isShow:false, title:'', params:[], fshow:''}},


    }
</script>




