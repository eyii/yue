<template>
	<section>
		<!--工具条-->
		<etoolbar v-model="filters"/>

		<elist v-model="isShow"/>
		<edialog v-model="isShow"/>
		<!--工具条-->
		<!--编辑界面-->



	</section>
</template>

<script>
    import { getUserListPage, removeUser } from '@/api/api';
    import elist from '@/components/eleme/table/elist'
	import edialog from '@/components/eleme/edialog/edialog'
    import etoolbar from '@/components/eleme/toolbar/etoolbar'


	export default {
        components: {etoolbar, edialog, elist},
		data(){
            return {
                isShow:false,
                filters: {
                    name: '',
                    fcheck:this.fcheck,
                    fadd:this.fadd,
                    fexport:this.fexport,
					page:0
                },
            }
		},
        methods:{
            fcheck(){
                getUserListPage(this.filters).then((res) => {

                   let users= [{id:1, date: '2016-05-02', name: '王小虎', address: '上海市普陀区金沙江路 1518 弄',op:''},
					           {id:2,date: '2016-05-04', name: '王da', address: '上海市普陀区金沙江路 1517 弄'}];
                    this.commit('setUsers',users);
                });
            },
            fadd(){
                debugger;

            //    let users=this.$store.getters.getUsers();
                return 1;
            },
            fexport(){
                debugger;

               // let users=this.$store.getters.getUsers();
                return 1;
            },
        }

	}

</script>

<style scoped>

</style>