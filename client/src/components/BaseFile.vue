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
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
export default {
  name: 'BaseFile',
  async mounted() {
    await this.fetchUserData()
    this.user = this.getUser
    console.log(this.user)
  },
  data() {
    return {
      user: {}
    }
  },
  computed: {
      ...mapGetters({
        getUser: 'user/getUser'      
      })
  },
  methods: {
    ...mapActions({
      fetchUser: 'user/fetchUser',
      updateUser: 'user/updateUser'
  }),
    async fetchUserData() {
      this.fetchUser({id: 1})
    },
    setUsername() {
      this.updateUser({username: 'hey_you'})
    }
  }
}
</script>
