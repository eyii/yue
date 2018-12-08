/*search:{
    url:"{:U('Jiechi/search')}",
        urls:"",
        form: [],
        success:this.success,
}*/

class post extends base{
    constructor(data) {
        super(data);
        this.post();
    }
    ecall(res) {
        super.ecall(res);
        this.cmp(this.catch,'操作异常',res);
    }
    scall(res){
        super.scall(res);
        this.getMsg();
        this.success_error();
        this.handle_success();
    }
    post() {
        Vue.http.post(this.url, this.param).then(this.scall.bind(this),this.ecall.bind(this));
    };
}