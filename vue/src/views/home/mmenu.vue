<template>
    <aside :class="collapsed?'menu-collapsed':'menu-expanded'">
    <el-menu :default-active="$route.path" class="el-menu-vertical-demo" @open="handleopen" @close="handleclose" @select="handleselect"
             unique-opened router v-show="!collapsed">
        <template v-for="(item,index) in $router.options.routes" v-if="!item.hidden">
            <el-submenu :index="index+''" v-if="!item.leaf">
                <template slot="title"><i :class="item.icon"></i>{{item.name}}</template>
                <el-menu-item v-for="child in item.children" :index="child.path" :key="child.path" v-if="!child.hidden">{{child.name}}</el-menu-item>
            </el-submenu>
            <el-menu-item v-if="item.leaf&&item.children.length>0" :index="item.children[0].path"><i :class="item.icon"></i>{{item.children[0].name}}</el-menu-item>
        </template>
    </el-menu>
    </aside>
</template>

<script>
    export default {
        name: "mmenu",
        data() {
            return {
                sysName:'Yue',
                collapsed:false,

            }
        },
        methods: {

            handleopen() {
                alert('handleopen')
                //console.log('handleopen');
            },
            handleclose() {
                alert('handleclose')
            },
            handleselect: function (a, b) {
            },

            //折叠导航栏
            collapse:function(){
                this.collapsed=!this.collapsed;
            },

        },
    }
</script>

<style scoped lang="scss">
    @import '~scss_vars';

    .container {
        position: absolute;
        top: 0px;
        bottom: 0px;
        width: 100%;

        .main {
            display: flex;
            // background: #324057;
            position: absolute;
            top: 60px;
            bottom: 0px;
            overflow: hidden;
            aside {
                flex:0 0 230px;
                width: 230px;
                // position: absolute;
                // top: 0px;
                // bottom: 0px;
                .el-menu{
                    height: 100%;
                }
                .collapsed{
                    width:60px;
                    .item{
                        position: relative;
                    }
                    .submenu{
                        position:absolute;
                        top:0px;
                        left:60px;
                        z-index:99999;
                        height:auto;
                        display:none;
                    }

                }
            }
            .menu-collapsed{
                flex:0 0 60px;
                width: 60px;
            }
            .menu-expanded{
                flex:0 0 230px;
                width: 230px;
            }
            .content-container {
                // background: #f1f2f7;
                flex:1;
                // position: absolute;
                // right: 0px;
                // top: 0px;
                // bottom: 0px;
                // left: 230px;
                overflow-y: scroll;
                padding: 20px;
                .breadcrumb-container {
                    //margin-bottom: 15px;
                    .title {
                        width: 200px;
                        float: left;
                        color: #ff0000;
                        margin-left: 25rem;
                        //	color: #475669;
                    }
                    .breadcrumb-inner {
                        float: right;
                    }
                }
                .content-wrapper {
                    background-color: #fff;
                    box-sizing: border-box;
                }
            }
        }
    }
</style>