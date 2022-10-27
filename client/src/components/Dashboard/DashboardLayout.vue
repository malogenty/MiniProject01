<template>
  <main class="dashboard">
    <ChartVisualisation
    @toggleFullScreen="toggleFullScreen"
    :fullscreen="fullscreen"
    />
    <UserTabs v-if="!fullscreen"
    />
  </main>
  </template>

<script>
import ChartVisualisation from './ChartVisualisation.vue';
import UserTabs from './UserTabs.vue';

export default {
  components: {
    ChartVisualisation,
    UserTabs
   },
   data() {
    return {
      fullscreen: false
    }
   },
   methods: {
    toggleFullScreen() {
      this.fullscreen = !this.fullscreen
    },
  }
}
</script>

<style lang="scss" scoped>
  main.dashboard {
    display: flex;
    flex-direction: column;
    width: 100vw;
    height: 100vh;
  }
</style>