<template>
  <div>
    Hey
    <button
    @click="fetchUserData">
      Click here Q
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
    getUsers() {
      return this.getAllUsers // => returns ['first_user']
    }
  },
  methods: {
    ...mapActions({
      fetchUser: 'user/fetchUser',
  }),
    fetchUserData() {
      this.fetchUser({id: 1})
    }
  }
}
</script>
