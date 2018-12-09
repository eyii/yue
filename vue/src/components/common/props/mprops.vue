
<div id="app">
    <input type="text" v-model="number">
    <input type="button" value="增加" v-click="increment"/>
    <input type="button" value="减少" v-click="subtract">
    <h3 v-bind="number"></h3>
</div>

<script>
    //初始化构造函数
    function Vm(options) {
        this._init(options);
    }

    Vm.prototype._init = function (options) {
        this.$options = options;
        this.$el = document.querySelector(options.el);
        this.$data = options.data;
        this.$methods = options.methods;
        this._binding = {};
        this._observer(this.$data);
        this._complie(this.$el);
    }


    Vm.prototype._observer = function (data) {

        if (!data) return;

        if (typeof data !== "object") throw new Error("data必须是一个对象");

        var self = this;
        Object.keys(data).forEach(function (key) {
            var oldValue = data[key];
            self._binding[key] = {_directives: []}
            var binding = self._binding[key];
            Object.defineProperty(data, key, {
                enumerable: true,
                configurable: true,
                get: function () {return oldValue;},
                set: function (newValue) {
                    if (oldValue == newValue) return;
                    oldValue = newValue;
                   binding._directives.forEach(function (item) {item.update();})
                }
            });
        })
    }

    Vm.prototype._complie = function (root) {
        var _this = this;
        var nodes = root.children;
        for (var i = 0; i < nodes.length; i++) {
            var node = nodes[i];
            if (node.children.length) this._complie(node);
            if (node.hasAttribute("v-click")) {
                node.onclick = (function () {
                    var attrVal = nodes[i].getAttribute("v-click");
                    return _this.$methods[attrVal].bind(_this.$data);
                })();
            }
            if (node.hasAttribute("v-model") && (node.tagName == "INPUT" || node.tagName == "TEXTAREA")) {//如果有v-model属性，并且元素为input或者textarea，我们监听它的input事件
                node.addEventListener("input", (function (key) {
                    var attrVal = node.getAttribute("v-model");
                    _this._binding[attrVal]._directives.push(new Watcher("input", node, _this, attrVal, "value",))
                    return function () {_this.$data[attrVal] = nodes[key].value;}
                })(i));
            }

            if (node.hasAttribute("v-bind")) {
                var attrVal = node.getAttribute("v-bind");
                _this._binding[attrVal]._directives.push(new Watcher('text', node, _this, attrVal, "innerHTML"))
            }
        }
    }


    function Watcher(name, el, vm, exp, attr) {
        this.name = name;
        this.el = el;
        this.vm = vm;
        this.exp = exp;
        this.attr = attr;
        this.update();
    }

    Watcher.prototype.update = function () {
        this.el[this.attr] = this.vm.$data[this.exp];
    }

    window.onload = function () {
        var vm = new Vm({
            el: "#app",
            data: { number: 0, age: 18},
            methods: {
                increment: function () {this.number++;},
                subtract: function () {this.number--;}
            }
        })
    }

</script>
