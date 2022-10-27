<template>
  <div v-if="user.id">
    <ClockView />
    <ChartView />
  </div>
</template>

<script>
import ChartView from "@/views/ChartView.vue";
import ClockView from "@/views/ClockView.vue";
import { mapActions, mapGetters } from "vuex";

export default {
  async created() {
      await this.fetchUser({id: this.$route.params.id})
  },
  computed: {
      ...mapGetters({
          getCurrentUser: 'currentUser/getUser'
      }),
      user() {
          return this.getCurrentUser
      }
  },
  name: "UserView",
  components: {
    ClockView,
    ChartView,
  },
  methods: {
    ...mapActions({
      fetchUser: "currentUser/fetchUser",
    }),
  },
};
</script>
