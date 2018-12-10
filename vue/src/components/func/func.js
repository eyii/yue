exports.install = function (Vue, options) {
    Vue.prototype.commit = function (name,data){

        this.$store.commit(name,data);
    };
    Vue.prototype.getters = function (key){
     return  this.$store.getters[key];
    };
};