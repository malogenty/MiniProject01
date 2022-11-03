<template>
  <div class="home">
    <ContainerLayout>
      <UserDashboard v-if="isEmployee" :user="currentUser"/>
      <TeamsGrid v-else :teams="currentUser.teams"/>
    </ContainerLayout>
  </div>
</template>

<script>
import UserDashboard from '@/components/v2/UserDashboard/UserDashboard.vue'
import { mapGetters } from 'vuex'
import ContainerLayout from '../components/Layout/ContainerLayout.vue'
import TeamsGrid from '../components/v2/TeamsGrid.vue'

export default {
  components: { ContainerLayout, TeamsGrid, UserDashboard },
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