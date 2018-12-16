exports.install = function (Vue, options) {
    Vue.prototype.commit = function (name,data){

        this.$store.commit(name,data);
    };
    Vue.prototype.getters = function (key){
     return  this.$store.getters[key];
    };
    Vue.prototype.setList=function (list) {
        this.commit('setUsers',list);
    }

    Vue.prototype.toArray=function (data) {
        if (!this.isObject(data)) return data;
        var arr = [];
        for (let i in data) arr.push(data[i]);
        return arr;
    }

    Vue.prototype.isObject=  function (value) {
        var type = typeof value;
        return type === 'function' || !!value && type == 'object';
    }

    Vue.prototype.addCol=  function (arr,cols) {
        if (!Array.isArray(cols)) return arr;

       let newArray= arr.map((item,i) =>{
            if (cols[i]==undefined)return item;
            let col=   cols[i];
           for (let key in col) item[key]=col[key]

          return item;
        })

        return newArray;
    }

    Vue.prototype.getByKey=function (arr,key,newKey=undefined) {

        let newArr=[];
        arr.map((item) =>{

            var obj = {};
            let val=item[key];
            if (newKey==undefined) {
                newArr.push(val);
                return item;
            }
            obj[newKey] = val;
            newArr.push(obj);
        })

        return newArr;
    }
    Vue.prototype.getByKey=function (url,file,filename,newKey=undefined) {
            let form={};
            form.param= new FormData();
            form.url=url;
           if (file)form.param.append('UploadForm[file]',file);
           form.param.append('filename',this.$route.path+'_'+filename);
            new VPost(form,this);
        return newArr;
    }

};


function log(data) {
console.log(data)
}