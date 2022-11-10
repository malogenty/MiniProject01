<template>
  <header>
    <span @click="goHome">{{
      this.showAccount
        ? "THE best tool to track your employee's attendance"
        : 'A time manager so that ALL your hours get paid !'
    }}</span>
    <button class="header-btn" @click="goToMyAccount" v-if="showAccount">
      My account
    </button>
    <button class="header-btn" @click="logout">Logout</button>
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
      currentUser: 'currentUser/getUser'
    }),
    showAccount() {
      return (
        this.currentUser.role === 'manager' ||
        this.currentUser.role === 'general_manager'
      )
    }
  }
}
</script>

<style scoped lang="scss">
@import '@/styles/colors.scss';

header {
  background-color: $green;
  width: 100%;
  display: flex;
  padding: 2%;
  margin-bottom: 1%;
  box-shadow: 0px 2px 7px 2px rgba(0, 0, 0, 0.33);
  -webkit-box-shadow: 0px 2px 7px 2px rgba(0, 0, 0, 0.33);
  span {
    margin-right: auto;
    cursor: pointer;
    font-weight: bold;
    color: $black;
  }
  .header-btn {
    height: 35px;
    width: 100px;
    border-radius: 6px;
    transition: all 200ms ease;
    border: none;
    cursor: pointer;
    &:hover {
      box-shadow: 3px 3px 0px 0px darken($green, 20%);
    }
  }
  button:first-of-type {
    margin-right: 1%;
  }
}
</style>
