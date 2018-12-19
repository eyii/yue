<template>
	<section>
		<!--<div>{{form.list}}</div>-->

			<el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
				<el-form :inline="true" >
					<ebtn @click="fcount" title="结算"/>
					<ebtn @click="form.list.forEach(item=> {item.C=null;})" title="清空"/>
					<ebtn @click="form.isShow=true" title="优惠"/>
					<uploadexcel v-model="form.bl"   title="上传比例"   filename="bl" :url="form.url" :autoread="true" />
					<uploadexcel v-model="form.list" title="上传会员表" filename="hy" :url="form.url"/>

					<downexcel v-model="form"/>
				</el-form>
			</el-col>
	    	<elist v-model="form"/>
		 <edialog v-model="form"/>
	</section>
</template>

<script>

    import elist from './elist'
	import edialog from '../../../components/eleme/edialog/edialog'
    import uploadexcel  from './uploadexcel';
    import downexcel from './downexcel'
    import ebtn from '../../../components/eleme/button/btnForm'
	export default {
        components: {uploadexcel,ebtn,downexcel, edialog, elist},
		data(){
            return {
                form: {
                    isShow:false,
                    name: '', fcheck:this.fcheck, fadd:this.fadd, page:0, list:[], bl:[],
					url:'http://f.cn/v1/upload/upload',
					fields: {'会员账号': 'A', '有效投注': 'B', '结果': 'C',},
				},

            }
		},
        methods:{
            fcheck(){}, fadd(){return 1;},
            fcount(){
                this.form.list.forEach(row=> { if (row.C!=null)return ; this.form.bl.forEach(bl=>{if(row.B>bl.A)row.C=bl.B});})
            }
        }
	}

</script>

<style scoped>

</style>