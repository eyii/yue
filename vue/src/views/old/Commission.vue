<template>
    <el-table id="out-table" :data="form" show-summary="true" show-overflow-tooltip="true" border size="mini">
        <el-table-column v-for="(item,key) in options" :label="item.text" :prop="item.value" width="130" v-if="item.show"  :width="item.width" >
            <!--通用-->
            <ecol slot-scope="scope" :keyname="item.value" :row="scope.row" :item="item">
               <span slot="common">{{scope.row[item.value]}}</span>
                <span slot="state">  {{ ['完成','申请','已取消','已支付','已失败','已删除'][scope.row.state] }}</span>
                <span slot="actionTime">{{moment.unix(scope.row.actionTime).format("YYYY-MM-DD HH:mm:ss")  }}</span>
                <span slot="handleTime">{{moment.unix(scope.row.handleTime).format("YYYY-MM-DD HH:mm:ss")  }}</span>
                <span slot="op" >
                          <el-button size="mini" @click="edit(scope.$index, scope.row,1,0)" v-if="scope.row.state==1"  type="success">确认打款</el-button>
                          <el-button size="mini" @click="dialogVisible=true;chexiaoForm.id=scope.row.id; " v-if="scope.row.state==1" type="danger">撤销提现</el-button>
                </span>
            </ecol>

        </el-table-column>
    </el-table>
    <epage v-bind:param="search" v-on:success="success"/>
</template>

<script>
    import elist from '../../components/eleme/table/elist'

    export default {
        name: "Commission",
        components: {elist},
        data() {
            return {
                time:1,
                sumbit_time:[],
                options: [
                    {value: 'uid',           text: 'UserID',  disabled:true,show:true,width:80,copy:false},
                    {value: 'userAccount',  text: '用户名',   disabled:true,show:true,width:100,copy:false},
                    {value: 'account',      text: '卡号',      disabled:true,show:true,width:220,copy:true} ,
                    {value: 'amount',       text: '提现金额',  disabled:true,show:true,width:140,copy:true},
                    {value: 'username',     text: '提现姓名',  disabled:true,show:true,width:120,copy:true},
                    {value: 'operator',     text: '操作人',    disabled:true,show:true,width:100,copy:false} ,
                    {value: 'bankName',      text: '银行类型',  disabled:true,show:true,width:120,copy:false} ,
                    {value: 'info',          text: '备注',      disabled:true,show:true,width:120,copy:false} ,
                    {value: 'state',         text: '状态',      disabled:true,show:true,width:120,copy:false} ,
                    {value: 'op',            text: '操作',      disabled:true,show:true,width:250,copy:false} ,
                    {value: 'actionTime',   text: '申请时间',   disabled:true,show:true,width:120,copy:false} ,
                    {value: 'handleTime',   text: '处理时间',   disabled:true,show:true,width:120,copy:false} ,
                ],
                urls:{
                    update:'/admin778899.php/tixian/update_cash',
                    check:'/admin778899.php/tixian/check',

                },
                state:[
                    {label:'全部', value:'',},
                    {label:'申请', value:'1',},
                    {label:'完成', value:'0',},
                    {label:'撤销', value:'4',},
                    {label:'锁定', value:'5',},
                ],
                value: '',
                form:[] ,
                dialogVisible:false,
                price:'',
                foo:'',
                filterTab:false,
                refreshInput:'30',
                refreshText:'',
                result:{
                    totalAmount:0,
                },
                search:{
                    url:'/admin778899.php/tixian/search',
                    tfrom:moment().add('days',-7).format('YYYY-MM-DD'),
                    tto:moment().format('YYYY-MM-DD'),
                    uid:'',
                    operator:'',
                    username:'',
                    state:'',
                    cash_from:'',
                    cash_to:'',
                    pageSize:10,
                    page:1,
                    total:0,
                },
                chexiaoForm:{ id:'', type:0, info:'',  }
            };
        },
        methods: {





        },
        mounted(){


        },
    }
</script>

<style scoped>

</style>


