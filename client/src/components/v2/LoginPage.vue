<template>
  <container-layout>
    <button @click="loginUser({username: 'test03', password: 'password'})">Login employee</button>
    <button @click="loginUser({username: 'test02', password: 'password'})">Login manager</button>
    <button @click="loginUser({username: 'test01', password: 'password'})">Login general_manager</button>
  </container-layout>
</template>

<script>
import { mapActions } from 'vuex'
import ContainerLayout from '../Layout/ContainerLayout.vue'

export default {
  components: { ContainerLayout },
  methods: {
    ...mapActions({
      login: 'currentUser/login'
    }),
    async loginUser({username, password}) {
      const res = await this.login({username, password})
      if(res.status === 200) {
        this.$router.push('/')
      } else {
        alert(res.erorr)
      }
    }
  }
}
</script>

<style>

</style>