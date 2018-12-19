<template>
    <edialog v-model="value">
        <slot>
            <el-form label-position="left" :inline="true" class="demo-form-inline">
                <el-form-item  v-for="(item,key) in items"    :label="item.text" :key="item.value">
                    <el-input  v-model="value.row[item.value]" style="width: 8rem" />
                </el-form-item>
            </el-form>
        </slot>
    </edialog>
</template>

<script>

    import edialog from '../../../components/eleme/edialog/base'
    import {items} from './option'
    export default {
        name: "addDialog",
        components:{edialog},
        props:{value:{isShow:false, title:'', row:{}, fshow:''}},
        data(){return {items:items}},
    }
</script>
<style scoped>
    .margin5rem{

    }
</style>

