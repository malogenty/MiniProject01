<template>
  <header>
    <button @click="$router.back()">go back</button>
    <span>A beautiful website indeed</span>
    <button @click="logout">Logout</button>
  </header>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  methods: {
    ...mapActions({
      logout: 'currentUser/logout'
    })
  }
}
</script>

<style scoped lang="scss">
  @import "@/styles/colors.scss";

  header {
    background-color: $green;
    width: 100%;
    display: flex;
    padding: 1vw;
    justify-content: space-between;
  }
</style>