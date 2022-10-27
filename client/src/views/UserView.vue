<template>
  <div v-if="user.id">
    <DashboardLayout/>
    </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import DashboardLayout from '../components/Dashboard/DashboardLayout.vue';

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
    DashboardLayout,
  },
  methods: {
    ...mapActions({
      fetchUser: "currentUser/fetchUser",
    }),
  },
};
</script>
