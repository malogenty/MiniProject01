<template>
  <ContainerLayout>
    <div class="settings">
      <span class="header">Edit {{user.username}} settings</span>
      <form @submit.prevent="handleFormSubmission">
        <label>
          username
          <input type="text" v-model="user.username" :disabled="disabled" @input="message = {}"/>
        </label>
        <label>
          email
          <input type="email" v-model="user.email" :disabled="disabled" @input="message = {}"/>
        </label>
        <button type="submit" :disabled="disabled">Submit</button>
        <span class="message" :class="{valid: message.status === 200, visible: message.msg}">{{message.msg}}</span>
      </form>
      <div class="actions">
        <button @click="promoteThisUser" v-if="canBePromoted">Promote user</button>
        <button @click="deleteThisUser" v-if="canBeDeleted">Delete user</button>
      </div>
    </div>
  </ContainerLayout>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import ContainerLayout from '../../Layout/ContainerLayout.vue'
export default {
  components: {ContainerLayout},
  props: {
    givenUser: {}
  },
  data() {
    return {
      user: this.givenUser,
      disabled: true,
      message: ''
    }
  },
  created() {
    this.disabled = this.givenUser.id !== this.currentUser.id
  },
  computed: {
    ...mapGetters({
      currentUser: 'currentUser/getUser'
    }),
    canBePromoted() {
      return this.currentUser.role === "general_manager" && this.user.role !== "manager" && this.user.role !== "general_manager"
    },
    canBeDeleted() {
      return this.currentUser.id === this.user.id || (this.currentUser.role === "general_manager" && this.user.role !== "general_manager")
    }
  },
  methods: {
    ...mapActions({
      editUser: 'currentUser/editUser',
      promoteUser: 'watchedUser/promoteUser',
      deleteUser: 'watchedUser/deleteUser',
    }),
    async handleFormSubmission() {
      if(this.disabled) return
      const res = await this.editUser({email: this.user.email, username: this.user.username})
      this.editMessage(res)
    },
    async promoteThisUser() {
      const res = await this.promoteUser(this.user.id)
      this.editMessage(res)
    },
    async deleteThisUser() {
      const res = await this.deleteUser(this.user.id)
      this.editMessage(res)
    },
    editMessage(res) {
      if (res.status === 200) this.message = {status: res.status, msg: "Success !"}
      if (res.status !== 200) this.message = {status: res.status, msg: res.error}
    }
  }
}
</script>

<style scoped lang="scss">
@import "@/styles/colors.scss";
.container {
  background: $gray;
  border-radius: 12px;
  .settings {
    display: flex;
    flex-direction: column;
    min-height: 500px;
    .header {
      text-align: center;
      font-weight: bold;
    }
    form {
      margin-top: 24px;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 8px;
      label {
        width: min-content;
      }
      button {
        padding: 4px 12px;
      }
      .message {
        color: red;
        display: none;
        &.valid {
          color: green;
        }
        &.visible {
          display: inline;
        }
      }
    }
    .actions {
      margin-top: auto;
      display: flex;
      justify-content: space-between;
      button {
        padding: 12px;
      }
    }
  }
}
</style>