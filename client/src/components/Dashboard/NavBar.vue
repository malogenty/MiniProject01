<template>
  <div>
    <UserModal v-if="editingUser" @closeModal="editingUser = !editingUser"/>
    <div class="controls">
      <div class="back" @click="goBackHome">
        <img src="/icons/arrow-left.png" alt="">
      </div>
      <span class="user" @click="editingUser = !editingUser">{{ user.username }}</span>
      <div class="full-screen" @click="$emit('toggleFullScreen')">
        <img src="/icons/fullscreen.png" alt="" v-if="fullscreen">
        <img src="/icons/fullscreen-exit.png" alt="" v-else>
      </div>
    </div>
  </div>
</template>

<script>
import UserModal from '@/components/Modals/EditUser.vue';

export default {
  props: {
    fullscreen: Boolean,
    user: {}
  },
  components: {
    UserModal
  },
  data() {
    return {
      editingUser: false
    }
  },
  methods: {
    goBackHome() {
      this.$router.push('/')
    }
  }

}
</script>

<style lang="scss" scoped>
.controls {
  height: 40px;
  display: flex;
  justify-content: space-between;
  div.back,
  div.full-screen {
    cursor: pointer;
    img {
      width: 36px;
      height: 36px;
    }
  }
  span.user {
    cursor: pointer;
    align-self: center;
  }
}
</style>