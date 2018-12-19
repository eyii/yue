<template>
    <section class="content-container">
        <div class="grid-content bg-purple-light">
            <el-col :span="24" class="content-wrapper">
                <transition name="fade" mode="out-in"><router-view></router-view></transition>
            </el-col>
        </div>
    </section>
</template>

<script>
    export default {
        name: "mcontent",
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