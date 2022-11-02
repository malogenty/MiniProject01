<template>
  <div class="home">
    <ContainerLayout>
      <div v-if="isEmployee">Logged in {{currentUser.username}}</div>
      <TeamsGrid v-else :teams="currentUser.teams"/>
    </ContainerLayout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import ContainerLayout from '../components/Layout/ContainerLayout.vue'
import TeamsGrid from '../components/v2/TeamsGrid.vue'
export default {
  components: { ContainerLayout, TeamsGrid },
  created() {
    if(!this.currentUser.id) this.$router.push('/login')
  },
  computed: {
    ...mapGetters({
      currentUser: 'currentUser/getUser'
    }),
    isEmployee() {
      return this.currentUser.role === 'employee'
    }
  }
}
</script>

<style>

</style>