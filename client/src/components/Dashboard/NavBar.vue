<template>
  <div class="controls">
      <div class="back">
        <img src="/icons/arrow-left.png" alt="">
      </div>
      <span class="user">{{ user.username }}</span>
      <div class="full-screen" @click="$emit('toggleFullScreen')">
        <img src="/icons/fullscreen.png" alt="" v-if="fullscreen">
        <img src="/icons/fullscreen-exit.png" alt="" v-else>
      </div>
    </div>
</template>

<script>
export default {
  props: {
    fullscreen: Boolean,
    user: {}
  },

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
}
</style>