<template>
  <el-form :model="form"  ref="form" label-position="left" label-width="0px" class="demo-ruleForm login-container">
    <h3 class="title">用户注册</h3>
    <el-form-item prop="username"><el-input type="text" v-model="form.param.username" auto-complete="off" placeholder="账号"></el-input></el-form-item>
    <el-form-item prop="password"><el-input type="text" v-model="form.param.password" auto-complete="off" placeholder="密码"></el-input></el-form-item>
    <el-checkbox v-model="form.param.rememberMe" checked class="remember">记住密码</el-checkbox>
    <el-form-item style="width:100%;"><el-button type="primary" style="width:100%;" @click.native.prevent="reg" :loading="logining">注册</el-button></el-form-item>
  </el-form>
</template>

<script>
  import { userReg } from '../../api/api';
  export default {
    data() {
      return {
        logining: false,
        form: {
            param:{
                username: 'admin',
                password: '123456',
                rememberMe: true,
            },
            success:this.success,
            catch:this.catch,
            msg:'登录失败'

          },



      };
    },
    methods: {
      success(msg,data){
          alert(msg);
          this.$router.push('/');
          this.logining = false;
      },
        catch(msg,data){
          alert(msg);
        },
        reg(ev) {
            this.logining = true;
            userReg(this.form,this);
      }
    }
  }

</script>

<style lang="scss" scoped>
  .login-container {
    /*box-shadow: 0 0px 8px 0 rgba(0, 0, 0, 0.06), 0 1px 0px 0 rgba(0, 0, 0, 0.02);*/
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    background-clip: padding-box;
    margin: 180px auto;
    width: 350px;
    padding: 35px 35px 15px 35px;
    background: #fff;
    border: 1px solid #eaeaea;
    box-shadow: 0 0 25px #cac6c6;
    .title {
      margin: 0px auto 40px auto;
      text-align: center;
      color: #505458;
    }
    .remember {
      margin: 0px 0px 35px 0px;
    }
  }
</style>