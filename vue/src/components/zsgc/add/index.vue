<template>
    <el-button  :size="size"   :type="type"  v-show="value.show"   @click="btnclick">{{title}}</el-button>
</template>

<script>


    export default {
        name: "btnAdd",
        props:{
            value:{
                url:'',
                param:{},
                success:'',
                catch:false,
                show:true
            },
            title:{default:'按钮', type:String,},
            click:{type: Function, default: null,},
            size:{type:String, default:'mini'},
            type:{
                type:String, default:'danger'
            }
        },
        methods:{
            btnclick(){
              if (this.click!=null) return   this.click();
                new VPost(this.value,this);
            }
        }


    }
</script>

