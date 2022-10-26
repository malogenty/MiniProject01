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
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
export default {
  name: 'StoreTest',
  async mounted() {
    await this.fetchUserData()
    this.user = this.getUser
    this.users = this.getUsers
  },
  data() {
    return {
      user: {},
      users: []
    }
  },
  computed: {
      ...mapGetters({
        getUser: 'user/getUser',
        getUsers: 'users/getAllUsers'
      })
  },
  methods: {
    ...mapActions({
      fetchUser: 'user/fetchUser',
      updateUser: 'user/updateUser',
      fetchWorkingTimesFT: 'user/fetchWorkingTimesStartEnd'
  }),
    async fetchUserData() {
      await this.fetchUser({id: 1})
    },
    setUsername() {
      this.updateUser({username: 'hey_you'})
    },
    fetchWorkingTimesFromTo() {
      this.fetchWorkingTimesFT({start: '2022-10-23', end: '2022-10-26'})
    }
  }
}
</script>
