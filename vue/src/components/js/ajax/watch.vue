<template>
        <input v-model="name"/>
</template>

<script>
    export default {
        name:'wath',
        props:{
            name:{
                type:String
            }
        },
        data () {
            return {
                author: "Jinkey"
            }
        },
        mounted:function(){
            this.author = 'lili'
        },
        watch:{
            name:function(){
                console.log(this.name);
            },

        }
    }
</script>