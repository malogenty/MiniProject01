<template>
  <div v-if="!loading">
    <nav>
      <router-link to="/">Home</router-link> |
      <router-link to="/clock">About</router-link>
      <router-link :to="{ name: 'clock', params: { username: 'mark2021' } }" >
      Profile
      </router-link>
    </nav>
    <router-view/>
  </div>
  <div v-else>
    Wait... Loading
  </div>
</template>

<script>
import { mapActions } from 'vuex';
export default {
  data() {
    return {
      loading: true
    }
  },
  async created() {
    await this.fetchUsers()
    this.loading = false;
  },
  methods: {
    ...mapActions({
      'fetchAllUsers': 'users/fetchAllUsers'
    }),
    async fetchUsers() {
      await this.fetchAllUsers()
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>
