<template>
  <div> hello</div>
  <div v-for="user in users" :key="user.id">
    <UserCard class="cards__item" :user="user"/>
  </div>
</template>

<script>
import UserCard from '@/components/UserCard.vue'
import { mapGetters } from 'vuex';

export default {
  name: "UserGrid",
  data() {
    return {
      users: []
    }
  },
  components: {
    UserCard
  },
  mounted() {
    this.users = this.getUsers                     
  },
  computed: {
      ...mapGetters({
        getUsers: 'users/getAllUsers'
      })
  },
};
</script>

<style>
.cards {
  display: flex;
  flex: 1 1;
  flex-wrap: wrap;
  justify-content: space-between;
  flex-basis: auto;
  margin: 0;
  padding: 0;
}

.cards__item {
  display: flex;
  padding: 1rem;
  @media (min-width: 40rem) {
    width: 50%;
  }
  @media (min-width: 56rem) {
    width: 33.3333%;
  }
}
</style>