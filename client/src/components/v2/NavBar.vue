<template>
  <header>
    <span @click="goHome">{{this.showAccount ? "THE best tool to track your employee's attendance" : "A time manager so that ALL your hours get paid !"}}</span>
    <button @click="goToMyAccount" v-if="showAccount">Go to my account</button>
    <button @click="logout">Logout</button>
  </header>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  methods: {
    ...mapActions({
      logout: 'currentUser/logout'
    }),
    goToMyAccount() {
      this.$router.push(`/user/${this.currentUser.id}`)
    },
    goHome() {
      this.$router.push('/')
    }
  },
  computed: {
    ...mapGetters({
      currentUser: "currentUser/getUser"
    }),
    showAccount() {
      return this.currentUser.role === "manager" || this.currentUser.role === "general_manager"
    }
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
    span {
      margin-right: auto;
      cursor: pointer;
      font-weight: bold;
      color: $black;
    }
    button:first-of-type {
      margin-right: 4px;
    }
  }
</style>