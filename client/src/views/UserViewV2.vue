<template>
  <ContainerLayout>
    <UserDashboard v-if="user.id" :user="user"/>
  </ContainerLayout>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import UserDashboard from '@/components/v2/UserDashboard/UserDashboard.vue'
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'
export default {
  components: { UserDashboard, ContainerLayout },
  async created() {
      if(!this.user.id) {
        await this.fetchUser(this.$route.params.id)
      }
  },
  data() {
    return {
      updated: 0
    }
  },
  computed: {
    ...mapGetters({
      user: 'watchedUser/getUser'
    })
  },
  methods: {
    ...mapActions({
      fetchUser: 'watchedUser/fetchUser'
    })
  },
}
</script>

<style>

</style>