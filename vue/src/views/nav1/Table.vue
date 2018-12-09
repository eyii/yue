<template>
	<section>
		<!--工具条-->




		<elist v-model="isShow"/>
		<edit v-model="isShow"/>
		<!--工具条-->

		<!--编辑界面-->



	</section>
</template>

<script>

    import elist from '../../components/eleme/table/elist'
	import edit from '../../components/eleme/edialog/edit'

	export default {
        components: {edit, elist},
		data(){
            return {
                isShow:false

            }
		},

	}

</script>

<style scoped>

</style>