export default class base {
    constructor(data,Vue,isDebugger) {

        this.isDebugger=isDebugger;
        this.Vue=Vue;
        this.error=data.error;
        this.url=data.url;
        this.param=data.param;
        this.catch=data.catch;
        this.success=data.success;
        this.Vue.$http.options.emulateJSON = true;
    }
    ecall(result) {
        if (this.isDebugger) debugger;
        this.result=result;
       this.sinit();
    }

    scall(result){

         this.result=result;
         this.sinit()
    }
    sinit(){

        var result=this.result;
        this.body=result.body;
        this.code=this.body.code;
        this.msg=this.body.msg;
        this.data=result.data;
        this.result=this.data.result;
    }
    getType(success){
        return false===success?false:typeof success;
    }
    cmp(callback, msg,res){

        var type=this.getType(callback);
        switch (type) {
            case  "function":                                                                                       return callback(msg,res);
            case  false:                                                                                             return '';
            case "string":                                                                                           alert(callback);break;
            case  'undefined':                                                                                             return alert(msg);
        }
    }
    getMsg(){

        this.msg=this.msg!=''?this.msg:this.error;
    }
    success_error(){

        if (this.code==200) return;
        this.cmp(this.catch,this.msg,this.result);
    }
    handle_success() {

        if(this.code!=200) return;
        this.cmp(this.success,this.msg,this.result);
    }
}
