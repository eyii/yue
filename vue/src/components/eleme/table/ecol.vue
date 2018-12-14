

<script>
    export default {
        name: "ecol",
        render: function (createElement) {

             return createElement('div',[createElement('div',  this.getSlot()),])
        },
        props: {
            ekey:'',
            value:{
                other:true,
                row:0,
                col:0,
                op:'',
            },
            index:'',

        },

        methods:{
            getSlot(){
                var  result=this.$slots[this.ekey];
                result= this.getOther(this.value,result);
                result=this.getCommon(result);
                result=this.getOp(result);
              //  debugger;
                return result;
            },
            getOther(val,result){
                if (val.other==false)  return result;
                if (this.index==val.row) result=this.$slots.other;
                return result;
            },
            getCommon(result){
                return (result==undefined)?this.$slots.common:result;

            },
            getOp(result){
                if (this.value.op=='') return result;
                return (this.ekey==this.value.op)?this.$slots[this.ekey]:result;

            }
        }
    }
</script>

<style scoped>

</style>


