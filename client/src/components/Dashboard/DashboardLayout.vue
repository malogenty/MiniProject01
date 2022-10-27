<template>
  <main class="dashboard">
    <div
    @toggleFullScreen="toggleFullScreen"
    :fullscreen="fullscreen"
    class="chart"
    />
    <div v-if="!fullscreen"
    class="actions (clock / working times)"
    />
  </main>
  </template>

<script>
export default {
  components: {
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