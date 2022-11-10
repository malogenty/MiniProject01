<template>

  <div class="teams-grid">
    <CardLayout v-for="team in teams" :key="team.id" @click="goToTeam(team.id)">
      {{team.name}}
    </CardLayout>
  </div>
</template>

<script>
import CardLayout from '@/components/Layout/CardLayout.vue';
import { mapActions } from 'vuex';

export default {
  components: {
    CardLayout
  },
  props: {
    teams: Array
  },
  methods: {
    ...mapActions({
      fetchTeam: 'watchedTeam/fetchTeam'
    }),
    async goToTeam(id) {
      await this.fetchTeam(id)
      this.$router.push(`/team/${id}`)
    }
  }
}
</script>

<style scoped>
  .teams-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 2vw;
  }
</style>