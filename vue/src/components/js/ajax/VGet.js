/*search:{
    url:"{:U('Jiechi/search')}",
        urls:"",
        form: [],
        success:this.success,
}*/
import VPost from '@/components/js/ajax/VPost';

export default  class VGet extends VPost{

    post() {
     this.Vue.$http.get(this.url, this.param).then(this.scall.bind(this),this.ecall.bind(this));

    };
}