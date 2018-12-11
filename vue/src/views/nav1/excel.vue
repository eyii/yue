<template>

     <HotTable></HotTable>

</template>

<script>

    import HotTable  from '@/components/eleme/upload/excel';
    export default {
        name:'excel',
        data: function() {
            return {
                settings: {
                    data: [
                        ["", "Ford", "Volvo", "Toyota", "Honda"],
                        ["2016", 10, 11, 12, 13],
                        ["2017", 20, 11, 14, 13],
                        ["2018", 30, 15, 12, 13]
                    ],
                    colHeaders: true,
                    rowHeaders: true,
                }
            };
        },
        components: {
            HotTable,

        }
    }
</script>

<style>
    @import "../../../node_modules/handsontable/dist/handsontable.full.css";
</style>