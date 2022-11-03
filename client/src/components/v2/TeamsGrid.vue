<template>
  <div class="teams-grid">
    <CardLayout v-for="team in teams" :key="team.id" @click="this.$router.push(`/teams/${team.id}`)">
      {{team.name}}
    </CardLayout>
  </div>
</template>

<script>
import CardLayout from '@/components/Layout/CardLayout.vue';

export default {
  components: {
    CardLayout
  },
  props: {
    teams: Array
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