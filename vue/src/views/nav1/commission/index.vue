<template>
	<section>
		 <etoolbar v-model="form"/>
		 <elist v-model="form"/>
		 <edialog v-model="form"/>

	</section>
</template>

<script>

    import elist from './elist'
	import edialog from '../../../components/eleme/edialog/edialog'
    import etoolbar from './etoolbar'
	import downexcel from './downexcel'

	export default {
        components: {etoolbar, edialog, elist},
		data(){
            return {
                form: {
                    isShow:false,
                    name: '',
                    fcheck:this.fcheck,
                    fadd:this.fadd,
					page:0,
					list:[],
					fields: {
						'比例': 'A',
						'关卡': 'B',
						'会员': 'C',
						'投注': 'D',
						'结果': 'E',
					},
                },

            }
		},
        methods:{
            fcheck(){
            },
            fadd(){
                debugger;
                return 1;
            },

        }

	}

</script>

<style scoped>

</style>