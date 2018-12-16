Array.prototype.test=function( fun ){
    alert(fun)
  /*  for( var i=0,n=this.length;i<n;i++) fun( i, this[i]);*/
}


Array.getByKey=  function (key,newKey=undefined) {

    let arr=this;
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
/*
Array.prototype.each=function( fun ){
    for( var i=0,n=this.length;i<n;i++) fun( i, this[i]);
}

//Array类的克隆函数
Array.prototype.clone=function(){
    var o=[];
    this.each(  function(k,v){o[k]=v;});
    return o;
}


Array.prototype.map=function(   fun  ){
    var o=[];
    this.each(function( k,v){o[k]=fun( k,v );} );
    return o;
}
//Array类的del函数：在ie中delete是保留字，所以用del做函数名
Array.prototype.del=function(  a  ){
    var o=this.clone();
    for( var i=o.length,n=0;i>n;i--)  if( o[i]==a ) o.splice(i,1 );

    return o;
}

Array.prototype.toString=function(){
    var str="";
    this.each(function(k, v){str+=k+":"+ v+",";
    });
    return str;
}

*/
