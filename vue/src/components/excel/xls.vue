<template>
    <JsonExcel :data= "json_data">导出</JsonExcel>
</template>

<script>
    import JsonExcel from 'vue-json-excel'

    export default {
        name: "xls",
        components: {JsonExcel,},
        data(){
            return {

                json_data: [
                    {   'name': 'Tony ',
                        'city': 'New York',
                        'country': 'USA',
                        'birthdate': '1978',
                    },
                    {  'name': 'tli',
                        'city': 'Athens',
                        'country': 'xl',
                        'birthdate': '1987',

                    }
                ],
                json_meta: [[{'key': 'charset', 'value': 'utf-8'}]],
            }
    }
    }
</script>

<style scoped>

</style>