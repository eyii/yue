exports.install = function (Vue, options) {
    Vue.prototype.commit = function (name,data){

        this.$store.commit(name,data);
    };
    Vue.prototype.text2 = function (){//全局函数2
        alert('执行成功2');
    };
};