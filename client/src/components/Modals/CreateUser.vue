<template>
  <ModalWrapper>
    <span class="close" @click="$emit('closeModal')">X</span>
    <span class="header">
      Create a new user !
    </span>
    <form @submit.prevent="createNewUser">
      <input type="text" v-model="user.username" placeholder="username"/>
      <input type="mail" v-model="user.email" placeholder="username@email.com"/>
      <button type="submit">Submit</button>
    </form>
    {{ status }}
  </ModalWrapper>
</template>

<script>
import { mapActions } from 'vuex'
import ModalWrapper from './ModalWrapper.vue'
export default {
  components: { ModalWrapper },
  data () {
    return {
      user: {
        username: '',
        email: ''
      },
      status: null
    }
  },
  methods: {
    ...mapActions({
      createUser: 'users/createUser'
    }),
    async createNewUser() {
      const {status} = await this.createUser(this.user)
      this.user.username = ''
      this.user.email = ''
      this.status = status === 200 ? 'Success !' : 'An error has occured'
    }
  }
}
</script>

<style lang="scss" scoped>
.close {
  cursor: pointer;
}
.header {
  display: flex;
  justify-content: center;
  font-weight: bold;
}
</style>