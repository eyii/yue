
<template>
    <div  @click="$emit('input',111)">X</div>
</template>
<script>
    export default {
        name:'sx',
        props: {
            value:false
        },

    }
</script>


<!--

<modal v-model="isShow"/>

<!--
import modal from  './sx'
components: {edit, elist,modal},
-->