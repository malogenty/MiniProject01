<template>
  <div>Search for a user</div>
  <input type="text" v-model="filters.searchUserTextValue" />
  <div class="cards__item" v-for="user in usersFiltered" :key="user.id">
    <UserCard @click="showUser(user.id)" :user="user" />
  </div>
</template>

<script>
import UserCard from "@/components/UserCard.vue";
import { mapGetters } from "vuex";

export default {
  name: "UserGrid",
  data() {
    return {
      users: Array,
      filters: {
        searchUserTextValue: "",
      },
    };
  },
  components: {
    UserCard,
  },
  mounted() {
    this.users = this.getUsers;
  },
  computed: {
    ...mapGetters({
      getUsers: "users/getAllUsers",
    }),
    usersFiltered: function () {
      if (this.filters.searchUserTextValue === "") return this.users;
      return this.users.filter((user) => {
        return user.username.match(this.filters.searchUserTextValue);
      });
    },
  },

  methods: {
    showUser(userId) {
      this.$router.push({ name: "user", params: { id: userId } });
    },
  },
};
</script>

<style>
.cards {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  flex-basis: auto;
  margin: 0;
  padding: 0;
}

.cards__item {
  display: inline-block;
  padding: 1rem;
  width: 25%;

  @media (min-width: 40rem) {
    width: 50%;
  }
  @media (min-width: 56rem) {
    width: 33.3333%;
  }
}
</style>