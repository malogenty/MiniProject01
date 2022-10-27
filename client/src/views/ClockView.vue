<template>
  <div class="about">
    <h1>Clock page for: {{this.$route.params.username}}</h1>
    <button @click="qsd">Clock In</button>
  </div>
</template>


<script>
import {mapActions, mapGetters} from 'vuex'

export default {
  data() {
    return {

    }
  },
  methods: {

  },
  computed: {

  }
}

</script>