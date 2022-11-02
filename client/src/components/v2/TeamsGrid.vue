<template>
  <div class="teams-grid">
    <CardLayout v-for="team in teams" :key="team.id">
      Hey !
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
    teams: []
  }
}
</script>

<style scoped>

</style>