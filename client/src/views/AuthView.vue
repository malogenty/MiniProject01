<template>
  <LoginPage2/>
</template>

<script>
import { mapGetters } from 'vuex';
import LoginPage2 from '@/components/v2/LoginPage2.vue';
export default {
  components: {
    LoginPage2
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