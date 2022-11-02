<template>
  <container-layout>
    <button @click="loginUser">
      Login
    </button>
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
    async loginUser() {
      const res = await this.login({id: 1})
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