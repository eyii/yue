<template>
    <edialog v-model="isShow">

    </edialog>
</template>

<script>
    import edialog from '@/components/eleme/edialog/edialog'
    export default {
        name: "edialogEdit",
        data(){
            return {
                isShow
            }
        },
        components: {edialog},
    }
</script>

<style scoped>

</style>