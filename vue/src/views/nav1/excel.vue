<template>

     <xls></xls>

</template>

<script>

    import xls  from '@/components/excel/xls';
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
            xls,

        }
    }
</script>
