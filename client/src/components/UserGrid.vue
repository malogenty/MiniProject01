<template>
  <div>
    <CreateUser @closeModal="modal = !modal" v-if="modal"/>
    <div class="controls">
      <div class="search">
        <div>Search for a user</div>
        <input type="text" v-model="filters.searchUserTextValue" />
      </div>
      <button @click="modal = !modal" class="add_user">Add a new user</button>
    </div>
    <div class="cards__item" v-for="user in usersFiltered" :key="user.id">
      <UserCard @click="showUser(user.id)" :user="user" />
    </div>
  </div>
</template>

<script>
import UserCard from "@/components/UserCard.vue";
import { mapGetters } from "vuex";
import CreateUser from '@/components/Modals/CreateUser.vue';

export default {
  name: "UserGrid",
  data() {
    return {
      users: Array,
      filters: {
        searchUserTextValue: "",
      },
      modal: false
    };
  },
  components: {
    UserCard,
    CreateUser,
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

<style lang="scss" scoped>
.controls {
  display: flex;
  justify-content: space-between;
  .add_user {
    background: burlywood;
    width: max-content;
    padding: 4px;
    margin: 0 4px;
    border-radius: 4px;
    cursor: pointer;
  }
}

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