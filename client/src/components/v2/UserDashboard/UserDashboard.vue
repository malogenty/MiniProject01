<template>
  <div class="user-dashboard">
    <div class="user-nav">
      <ul>
        <li @click="setTab('dashboard')" :class="tab === 'dashboard' && 'selected'" >Dashboard</li>
        <li @click="setTab('schedule')" :class="tab === 'schedule' && 'selected'">Schedule</li>
        <li @click="setTab('settings')" :class="tab === 'settings' && 'selected'">Settings</li>
      </ul>
    </div>
    <DashboardTab v-if="tab === 'dashboard'" :givenUser="user"/>
    <ScheduleTab v-if="tab === 'schedule'" :givenUser="user"/>
    <SettingsTab v-if="tab === 'settings'" :givenUser="user"/>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
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
  async created() {
    if(!this.watchedUser.id) await this.fetchUser(this.user.id)
  },
  computed: {
    ...mapGetters({
      watchedUser: 'watchedUser/getUser'
    })
  },
  methods: {
    ...mapActions({
      fetchUser: 'watchedUser/fetchUser'
    }),
    setTab(tab) {
      this.tab = tab
    }
  },
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
          position: relative;
          border-radius: 4px;
          cursor: pointer;
          padding: 8px 10px;        }

        li::after {
          background: none repeat scroll 0 0 transparent;
          content: "";
          display: block;
          height: 2px;
          position: absolute;
          bottom: 0;
          left: 50%;
          background: black;
          transition: width 0.3s ease 0s, left 0.3s ease 0s;
          width: 0;
        }
        li:hover::after, .selected::after {
          width: 100%;
          left: 0;
        }
      }
    }
  }
</style>