

<script>
    export default {
        name: "ecol",
        render: function (createElement) {
            var common='';
            common=this.$slots[this.keyname];
            if(common==undefined)common=this.$slots.common;
            return createElement('div',[createElement('div', common),])
        },
        props: {
            keyname:'',
            row: '',
            item: '',
        }
    }
</script>

<style scoped>

</style>


