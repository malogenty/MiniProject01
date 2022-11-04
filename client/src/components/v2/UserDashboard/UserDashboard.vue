<template>
  <div class="user-dashboard">
    <div class="user-nav">
      <ul>
        <li @click="setTab('dashboard')">Dashboard</li>
        <li @click="setTab('schedule')">Schedule</li>
        <li @click="setTab('settings')">Settings</li>
      </ul>
    </div>
    <DashboardTab v-if="tab === 'dashboard'" :givenUser="user"/>
    <ScheduleTab v-if="tab === 'schedule'" :givenUser="user"/>
    <SettingsTab v-if="tab === 'settings'" :givenUser="user"/>
  </div>
</template>

<script>
import DashboardTab from './DashboardTab.vue'
import ScheduleTab from './ScheduleTab.vue'
import SettingsTab from './SettingsTab.vue'
export default {
  components: { DashboardTab, ScheduleTab, SettingsTab },
  props: {
    user: {}
  },
  data() {
    return {
      tab: "dashboard"
    }
  },
  methods: {
    setTab(tab) {
      this.tab = tab
    }
  }
}
</script>

<style scoped lang="scss">
@import "@/styles/colors.scss";
  .user-dashboard {
    .user-nav {
      display: flex;
      justify-content: center;
      padding-bottom: 12px;
      ul {
        display: flex;
        width: min-content;
        justify-content: center;
        list-style: none;
        gap: 12px;
        margin: 0;
        > li {
          padding: 8px;
          background: $khaki;
          border-radius: 4px;
          cursor: pointer;
        }
      }
    }
  }
</style>