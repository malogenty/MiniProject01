<template>
  <div class="about">
    <h1>Clock page for: {{this.$route.params.username}}</h1>
    <table style="">
      <thead>
        <tr>
          <td>Time clocked</td>
          <td>Status</td>
        </tr>
      </thead>
      <tr v-for="clock in user.clocks" :key="clock.id">
          <td>{{ clock.time }}</td>
          <td>{{ clock.status }}</td>
        </tr>
    </table>
     
    <button @click="clocked = !clocked;this.createClock({status: true})"><p v-if="clocked">Clock In</p><p v-else>Clock Out</p></button>
  </div>
</template>


<script>
import {mapActions, mapGetters} from 'vuex'

export default {

  async created() {
    await this.fetchUserClocks()
    this.user = this.getCurrentUser
    console.log(this.user)
  },
  async sendClock() {
    console.log("Clocked 1")
    this.createClock({status: true})
    console.log("Clocked 2")
  },
  data() {
    return {
      clocked: true,
      user: {}
    }
  },
  methods: {
    ...mapActions({
      fetchUserClocks: 'currentUser/fetchClocks',
      createClock: "currentUser/createClock"
    })
  },
  computed: {
    ...mapGetters({
      getCurrentUser: 'currentUser/getUser'
    })
  }
}

</script>