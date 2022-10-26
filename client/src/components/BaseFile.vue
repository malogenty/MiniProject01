<template>
  <div>
    Hey
    <button
    @click="fetchUserData">
      Click here to get id 1
    </button>

    <button
    @click="setUsername">
      click here to set username to 'hey_you'
    </button>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
export default {
  name: 'BaseFile',
  computed: {
      ...mapGetters([
    'getAllUsers'
    ]),
    getUser() {
      return this.getUser(1) // => returns ['first_user']
    }
  },
  methods: {
    ...mapActions({
      fetchUser: 'user/fetchUser',
      updateUser: 'user/updateUser'
  }),
    fetchUserData() {
      this.fetchUser({id: 1})
    },
    setUsername() {
      this.updateUser({username: 'hey_you'})
    }
  }
}
</script>
