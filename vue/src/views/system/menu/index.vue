<template>
	<section>
		<!--<div>{{form.list}}</div>-->

			<el-col :span="24" class="toolbar" style="padding-bottom: 0px;">
				<el-form :inline="true" ><ebtn @click="form.addform.isShow=true" title="新增"/></el-form>
			</el-col>
	    	<elist v-model="form.list"/>
		   <edialog v-model="form.list"/>
         <addDialog v-model="form.addform"></addDialog>
	</section>
</template>

<script>

    import elist from './elist'
	import edialog from '../../../components/eleme/edialog/edialog'
    import btnBlue from '../../../components/eleme/button/btnBlue'
    import addDialog from './addDialog'
    import ebtn from '../../../components/eleme/button/btnForm'
    import {addMenu} from "../../../api/api";
	export default {
        components: {ebtn, edialog, elist,btnBlue,addDialog},
		data(){
            return {
               form:{
                   list: {
                       isShow:false,
                       name: '', fcheck:this.fcheck, fadd:null, page:0, list:[], bl:[],
                       url:'http://f.cn/v1/menu',
                   },
                   addform:{isShow:false, title:'111', params:[], fshow:this.addSumbit,success:this.aSuccess,catch:this.catch}
			   }

            }
		},
        methods:{
            fcheck(){},
			aSuccess(msg,data){
               alert('成功')
			},
			catch(msg,data){
                alert('失败')
			},
			addSumbit(){
                addMenu(this.form.addform,this);

			},
            add(){

             //  this.addRow(this.form.list.list,{path:'',parent:'',component:'',name:'',icon:'',hidden:0,redirect:''})
            },

            fcount(){
                this.form.list.list.forEach(row=> {
                    if (row.C!=null)return ;
                    this.form.list.bl.forEach(bl=>{if(row.B>bl.A)row.C=bl.B*row.B;});})
            }
        }
	}

</script>

<style scoped>

</style>