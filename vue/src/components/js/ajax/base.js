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
        this.data=result;
       this.sinit();
    }

    scall(result){

         this.data=result;
         this.sinit()
    }
    sinit(){

        var result=this.data;
        var body= this.body=result.body;
        this.code=body.code;
        this.msg=body.msg;
        this.data=body.data;
       // this.result=this.body.data;
    }
    getType(success){
        return false===success?false:typeof success;
    }
    cmp(callback, msg,data){

        var type=this.getType(callback);
        switch (type) {
            case  "function":                                                                                       return callback(msg,data);
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
        this.cmp(this.catch,this.msg,this.data);
    }
    handle_success() {

        if(this.code!=200) return;
        this.cmp(this.success,this.msg,this.data);
    }
}
