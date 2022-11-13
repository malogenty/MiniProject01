<template>
  <ContainerLayout>
    <TeamMetrics  v-if="team.id" :givenTeam="team"/>
    <div class="users-list">
      <h2>All users</h2>
      <div class="users-grid">
      <CardLayout v-for="user in team.users" :key="user.id" @click="goToUser(user.id)">
        <span>
          {{ user.username }}
        </span>
        <span>
          {{ user.role }}
        </span>
      </CardLayout>
    </div>
    </div>
  </ContainerLayout>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import CardLayout from '@/components/Layout/CardLayout.vue'
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'
import TeamMetrics from '@/components/v2/TeamMetrics.vue'
export default {
  components: { CardLayout, ContainerLayout, TeamMetrics },
  async created() {
    if (!this.team.id) {
      await this.fetchTeam(this.$route.params.id)
    }
  },
  computed: {
    ...mapGetters({
      team: 'watchedTeam/getTeam'
    })
  },
  methods: {
    ...mapActions({
      fetchTeam: 'watchedTeam/fetchTeam',
      fetchUser: 'watchedUser/fetchUser'
    }),
    async goToUser(id) {
      await this.fetchUser(id)
      this.$router.push(`/user/${id}`)
    }
  }
}
</script>

<style scoped>
  .users-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 2vw;
  }

</style>