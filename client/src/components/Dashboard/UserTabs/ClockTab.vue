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
     
    <button @click="createClock">
      <span>Clock {{ clocked ? 'out' : 'in' }}</span>
    </button>
    
  </div>
</template>


<script>
import {mapActions, mapGetters} from 'vuex'

export default {
  async created() {
    await this.fetchUserClocks()
    this.clocked =  this.user.clocks[this.user.clocks.length - 1]?.status
  },
  data() {
    return {
      clocked: null
    }
  },
  methods: {
    ...mapActions({
      fetchUserClocks: 'currentUser/fetchClocks',
      createNewClock: 'currentUser/createClock'
    }),
    createClock() {
      this.createNewClock({status: !this.clocked, lastClock: this.user.lastClock})
      this.clocked = !this.clocked
    }
  },
  computed: {
    ...mapGetters({
      user: 'currentUser/getUser'
    })
  }
}

</script>