<template>
  <ContainerLayout>
    <div class="settings">
      <span class="header">{{ user.username }}'s settings</span>
      <form class="form" @submit.prevent="handleFormSubmission">
        <div class="form-group">
          <label> username </label>
          <input
            type="text"
            v-model="user.username"
            :disabled="disabled"
            @input="message = {}"
          />
        </div>
        <div class="form-group">
          <label> email </label>
          <input
            type="email"
            v-model="user.email"
            :disabled="disabled"
            @input="message = {}"
          />
        </div>
        <button type="submit" :disabled="disabled">Submit</button>
        <span
          class="message"
          :class="{ valid: message.status === 200, visible: message.msg }"
          >{{ message.msg }}</span
        >
      </form>
      <div class="actions">
        <button @click="promoteThisUser" v-if="canBePromoted">Promote user</button>
        <button @click="customClockOut" v-if="canBeClockedOut">Custom clock out</button>
        <button @click="deleteThisUser" v-if="canBeDeleted">Delete user</button>
      </div>
    </div>
  </ContainerLayout>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'
import moment from 'moment'

export default {
  components: { ContainerLayout },
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
    canBeClockedOut() {
      return (this.currentUser.role === "general_manager" || this.currentUser.role === "manager") && this.user.role === "employee"
    },
    canBePromoted() {
      return (
        this.currentUser.role === 'general_manager' &&
        this.user.role !== 'manager' &&
        this.user.role !== 'general_manager'
      )
    },
    canBeDeleted() {
      return (
        this.currentUser.id === this.user.id ||
        (this.currentUser.role === 'general_manager' &&
          this.user.role !== 'general_manager')
      )
    }
  },
  methods: {
    ...mapActions({
      editUser: 'currentUser/editUser',
      promoteUser: 'watchedUser/promoteUser',
      deleteUser: 'watchedUser/deleteUser',
      clockOut: 'watchedUser/customClockOut'
    }),
    async handleFormSubmission() {
      if (this.disabled) return
      const res = await this.editUser({
        email: this.user.email,
        username: this.user.username
      })
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
    async customClockOut() {
      const date = prompt("Please enter custom clock out date time like so", moment().format("YYYY-MM-DD HH:mm:ss"))
      if(!moment(date).isValid()) return alert("Not a valid date.")
      return await this.clockOut(date)
     },
    editMessage(res) {
      if (res.status === 200)
        this.message = { status: res.status, msg: 'Success !' }
      if (res.status !== 200)
        this.message = { status: res.status, msg: res.error }
    }
  }
}
</script>

<style scoped lang="scss">
@import '@/styles/colors.scss';
.container {
  .settings {
    background: $light_grey;
    padding: 2%;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    min-height: 500px;
    .header {
      font-weight: bold;
      font-size: 1.5em;
      margin: 0 auto 0 0;
    }
    .form {
      margin-top: 24px;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      max-width: 30%;
      gap: 8px;
      &-group {
        width: 100%;
        display: flex;
        justify-content: space-between;
        input {
          border-radius: 6px;
          padding: 1%;
          border: 1px solid rgb(219, 219, 219);
        }

        input:focus {
          outline: solid;
          outline-width: 1px;
          outline-color: black;
        }
      }
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
    button {
      height: 35px;
      border-radius: 6px;
      transition: all 200ms ease;
      border: none;
      cursor: pointer;
      background-color: white;
      border: 1px solid rgb(219, 219, 219);
      &:hover {
        box-shadow: 2px 2px 0px 0px darken(#f0f0f0, 20%);
        -webkit-box-shadow: 2px 2px 0px 0px darken(#f0f0f0, 20%);
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
