<template>
<section class="forms-section">
  <h1 class="section-title">Time Manager</h1>
  <div class="forms">
    <div class="form-wrapper" :class="{isactive: isActive}">
      <button type="button" class="switcher switcher-login" @click="isActive = true">
        Login
        <span class="underline"></span>
      </button>
      <form class="form form-login">
        <fieldset>
          <legend>Please, enter your email and password for login.</legend>
          <div class="input-block">
            <label for="login-email">E-mail</label>
            <input v-model="emailLogin" placeholder="example@example.com" id="login-email" type="email" required>
          </div>
          <div class="input-block">
            <label for="login-password">Password</label>
            <input v-model="passwordLogin" id="login-password" type="password" required>
          </div>
        </fieldset>
        <button type="submit" class="btn-login">Login</button>
      </form>
    </div>
    <div class="form-wrapper" :class="{isactive: !isActive}">
      <button type="button" class="switcher switcher-signup" @click="isActive = false">
        Sign Up
        <span class="underline"></span>
      </button>
      <form class="form form-signup">
        <fieldset>
          <legend>Please, enter your email, password and password confirmation for sign up.</legend>
          <div class="input-block">
            <label for="signup-email">E-mail</label>
            <input v-model="emailSignUp" placeholder="example@example.com" id="signup-email" type="email" required>
          </div>
          <div class="input-block">
            <label for="signup-username">Username</label>
            <input v-model="usernameSignUp" id="signup-username" placeholder="Username" type="username" required>
          </div>
          <div class="input-block">
            <label for="signup-password">Password</label>
            <input v-model="passwordSignUp" id="signup-password" type="password" required>
          </div>
        </fieldset>
        <button type="submit" class="btn-signup">Continue</button>
      </form>
    </div>
  </div>
</section>
</template>

<script>
import { mapActions } from 'vuex'


export default {
  data() {
    return {
      isActive: "login",
      emailLogin: "",
      passwordLogin: "",
      emailSignUp: "",
      usernameSignUp: "",
      passwordSignUp: ""
    }
  },
  methods: {
    ...mapActions({
      login: 'currentUser/login'
    }),
    async loginUser({email, username}) {
      const res = await this.login({email, username})
      if(res.status === 200) {
        this.$router.push('/')
      } else {
        alert(res.error)
      }
    }
  }
}
</script>

<style>
  @import "@/styles/login.css";
</style>