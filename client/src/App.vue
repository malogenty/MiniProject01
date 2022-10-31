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
*,
*::before,
*::after {
  box-sizing: border-box;
}

html {
  background-color: #f0f0f0;
}

body {
  /* color: @gray; */
  font-family: "Roboto", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-style: normal;
  font-weight: 400;
  letter-spacing: 0;
  padding: 0;
  margin: 0;
}

img {
  height: auto;
  max-width: 100%;
  vertical-align: middle;
}

</style>
