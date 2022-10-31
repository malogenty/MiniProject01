<template>
  <div class="tabs">
    <ClockTab/>
  </div>
</template>

<script>
import ClockTab from './UserTabs/ClockTab.vue';
export default {
  components: {
    ClockTab
  }

}
</script>

<style scoped>
.tabs {
  height: 29vh;
}
</style>