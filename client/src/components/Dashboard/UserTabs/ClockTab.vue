<template>
  <div class="clock">
    <h1>Clock page</h1>
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
      this.createNewClock({status: !this.clocked})
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

<style scoped>
  .clock {
    max-height: 100%;
    overflow: auto;
  }
</style>