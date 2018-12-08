<!--
<three>
    <h2 slot="header">标题</h2>
    <p  slot="main">正文内容</p>
    &lt;!&ndash; 这个不会渲染出来的 &ndash;&gt;
    <p>正文内容</p>
    <div slot="footer">底部信息</div>
</three>


js
import three from './components/three'
export default {
  components:{
    three
  }
}
-->


<template>
    <div class="three">
        <div class="header">
            <slot name="header"></slot>
        </div>
        <div class="main">
            <slot name="main"></slot>
        </div>
        <div class="footer">
            <slot name="footer"></slot>
        </div>
    </div>
</template>

<script>
    export default {
        name: "mslot"
    }

</script>

<style scoped>

</style>







