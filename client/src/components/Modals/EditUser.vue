<template>
  <modalWrapper>
    <span class="close" @click="$emit('closeModal')">X</span>
    <span class="header">
      Edit user {{getUser.username}}
    </span>
    <div class="edit">
      <form @submit.prevent="editUser">
        <input type="text" v-model="user.username"/>
        <input type="text" v-model="user.email">
        <button type="submit">Submit</button>
      </form>
    </div>
    <div class="delete">
      <form @submit.prevent="deleteUser">
        <button>Delete user</button>
      </form>
      {{ status }}
    </div>
    
  </modalWrapper>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import ModalWrapper from './ModalWrapper.vue'

export default {
  components: { ModalWrapper },
  name: 'UserModal',
  created() {
    this.user = this.getUser
  },
  data() {
    return {
      user: {},
      status: null
    }
  },
  computed: {
    ...mapGetters({
      getUser: 'currentUser/getUser'
    })
  },
  methods: {
    ...mapActions({
      updateUser: 'currentUser/updateUser',
      deleteCurrUser: 'currentUser/deleteUser'
    }),
    async editUser() {
      const {status} = await this.updateUser({username: this.user.username, email: this.user.email})
      this.status = status === 200 ? 'Success !' : 'An error has occured'      
    },
    async deleteUser() {
      if(confirm('Are you sure you want to delete this user ? This is irreversible.')) {
        const {status} = await this.deleteCurrUser()
        if(status === 204) {
          this.$router.push('/')
        } else {
          this.status = 'An error has occured'      
        }
      }
        
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