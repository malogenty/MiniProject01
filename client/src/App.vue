<template>
  <div v-if="!loading">
    <!-- <nav>
      <router-link to="/">Home</router-link> |
      <router-link :to="{ name: 'clock', params: { username: 'mark2021' } }" >
      Clock test
      </router-link>
    </nav> -->
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

<style lang="scss">
  body {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
  }
  * {
    box-sizing: border-box;
  }
</style>
