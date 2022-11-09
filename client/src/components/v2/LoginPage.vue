<template>
  <container-layout>
    <button @click="loginUser({email: 'test03@gmail.com', username: 'test03'})">Login employee</button>
    <button @click="loginUser({email: 'test02@gmail.com', username: 'test02'})">Login manager</button>
    <button @click="loginUser({email: 'test01@gmail.com', username: 'test01'})">Login general_manager</button>
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

</style>