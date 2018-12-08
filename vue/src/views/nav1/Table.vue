<template>
	<section>
		<!--工具条-->



		<elist :showDialog.sync="showDialog" ></elist>
		<edit :showDialog.sync="showDialog"></edit>
		<!--工具条-->
		<el-button @click="show">顶顶顶顶</el-button>

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
                showDialog: false,//编辑界面是否显示

            }
		},
		methods:{
            show(){
                this.showDialog=true;
                alert('ttt');
			}
		}
	}

</script>

<style scoped>

</style>