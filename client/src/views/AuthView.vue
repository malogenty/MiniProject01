<template>
  <LoginPage/>
</template>

<script>
import { mapGetters } from 'vuex';
import LoginPage from '@/components/v2/LoginPage.vue';
export default {
  components: {
    LoginPage
  },
  created() {
    if(this.currentUser.id) this.$router.push('/')
  },
  computed: {
    ...mapGetters({
      currentUser: 'currentUser/getUser'
    })
  }
}
</script>

<style>

</style>