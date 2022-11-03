<template>
  <container-layout>
    <button @click="loginUser(3)">Login employee</button>
    <button @click="loginUser(2)">Login manager</button>
    <button @click="loginUser(1)">Login general_manager</button>
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
    async loginUser(id) {
      const res = await this.login({id})
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