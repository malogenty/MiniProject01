<template>
  <div>
    {{user.email}}
    <button
    @click="fetchUserData">
      Click here to get id 1
    </button>

    <button
    @click="setUsername">
      click here to set username to 'hey_you'
    </button>
    <button
    @click="fetchWorkingTimesFromTo">
      click here to fetch working times
    </button>
    <button
    @click="fetchClocks">
      click here to fetch clocks
    </button>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
export default {
  name: 'StoreTest',
  mounted() {
  },
  data() {
    return {
      user: {},
      users: []
    }
  },
  computed: {
      ...mapGetters({
        getUser: 'currentUser/getUser',
        getUsers: 'users/getAllUsers',
      })
  },
  methods: {
    ...mapActions({
      fetchUser: 'currentUser/fetchUser',
      updateUser: 'currentUser/updateUser',
      fetchWorkingTimesFT: 'currentUser/fetchWorkingTimesStartEnd',
      fetchUserClocks: 'currentUser/fetchClocks'
  }),
    async fetchUserData() {
      await this.fetchUser({id: 1})
    },
    setUsername() {
      this.updateUser({username: 'hey_you'})
    },
    async fetchWorkingTimesFromTo() {
      await this.fetchWorkingTimesFT({start: '2022-10-23', end: '2022-10-26'})
    },
    async fetchClocks() {
      await this.fetchUserClocks()
    }
  }
}
</script>
