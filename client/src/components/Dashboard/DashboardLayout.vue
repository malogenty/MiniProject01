<template>
  <main class="dashboard">
    <NavBar
    :fullscreen="fullscreen"
    @toggleFullScreen="toggleFullScreen"
    :user="user"
    />
    <div class="container">
      <ChartVisualisation
      @toggleFullScreen="toggleFullScreen"
      :fullscreen="fullscreen"
      :user="user"
      />
      <UserTabs v-if="!fullscreen"
      />
    </div>
  </main>
  </template>

<script>
import ChartVisualisation from './ChartVisualisation.vue';
import UserTabs from './UserTabs.vue';
import NavBar from './NavBar.vue';
import { mapGetters } from 'vuex';

export default {
  components: {
    ChartVisualisation,
    UserTabs,
    NavBar
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
  },
  computed: {
    ...mapGetters({
      user: 'currentUser/getUser'
    })
  },
}
</script>

<style lang="scss" scoped>
  main.dashboard {
    display: flex;
    flex-direction: column;
    max-width: 100vw;
    height: 100vh;
    .container {
      padding: 1vw;
    }
  }
</style>