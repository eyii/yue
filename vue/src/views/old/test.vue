<template>

     <watcher :name="name"></watcher>

</template>

<script>

    import watcher from '@/components/js/ajax/watch.vue';

    export default {
        data () {
            return {
                msg: 'Hello Vue!',
                name:'lili'
            }
        },
        components: { watcher}
    }
</script>
