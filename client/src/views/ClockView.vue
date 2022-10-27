<template>
  <div class="about">
    <h1>Clock page for: {{this.$route.params.username}}</h1>
    <h1>{{ user.clocks }}</h1>
    <button @click="clocked = !clocked"><p v-if="clocked">Clock In</p>
<p v-else>Clock Out</p></button>
    
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
  data() {
    return {
      clocked: true,
      user: {}
    }
  },
  methods: {
    ...mapActions({
      fetchUserClocks: 'currentUser/fetchClocks'
    })
  },
  computed: {
    ...mapGetters({
      getCurrentUser: 'currentUser/getUser'
    })
  }
}

</script>