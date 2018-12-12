/*search:{
    url:"{:U('Jiechi/search')}",
        urls:"",
        form: [],
        success:this.success,
}*/
import base from '@/components/js/ajax/base';
import axios from "axios";
export default  class VPost extends base{
    constructor(data,Vue,isDebugger=false) {
        super(data,Vue,isDebugger);
        this.post();
    }
    ecall(res) {
        if (this.isDebugger) debugger;
        super.ecall(res);
        this.cmp(this.catch,'操作异常',res);
    }
    scall(res){
        if (this.isDebugger) debugger;
        super.scall(res);
        this.getMsg();
        this.success_error();
        this.handle_success();
    }
    post() {
  //    axios({method:'post', url:this.url, data:this.param});//.then(this.scall.bind(this),this.ecall.bind(this));


       this.Vue.$http.post(this.url, this.param).then(this.scall.bind(this),this.ecall.bind(this));

    };
}