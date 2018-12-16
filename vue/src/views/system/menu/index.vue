<template>
	<section>
		<!--<div>{{form.list}}</div>-->

			<el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
				<el-form :inline="true" ><ebtn @click="fcount" title="结算"/></el-form>
			</el-col>
	    	<elist v-model="form"/>
		   <edialog v-model="form"> </edialog>
	</section>
</template>

<script>

    import elist from './elist'
	import edialog from '../../../components/eleme/edialog/edialog'


    import ebtn from '../../../components/eleme/button/btnForm'
	export default {
        components: {uploadexcel,ebtn,downexcel, edialog, elist},
		data(){
            return {
                form: {
                    isShow:false,
                    name: '', fcheck:this.fcheck, fadd:this.fadd, page:0,
					list:[],
					bl:[],
					url:'http://f.cn/v1/upload/upload?XDEBUG_SESSION_START=15899',

				},

            }
		},
        methods:{
            fcheck(){},
            fadd(){
                debugger;
                return 1;
            },
            fcount(){
                this.form.list.forEach(row=> {
                    if (row.C!=null)return ;
                    this.form.bl.forEach(bl=>{
                        if(row.B>bl.A)row.C=bl.B*row.B;
                    });
                })

            }
        }
	}

</script>

<style scoped>

</style>