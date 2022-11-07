<template>
  <ContainerLayout>
    <div class="user-schedule">
      <span class="header">{{givenUser.username}}'s schedule</span>
      <div class="calendar-container">
        <VueCal 
        ref="vuecal"
        hideWeekends
        hideViewSelector 
        :dblclickToNavigate="false" 
        :editable-events="canEdit"
        :drag-to-create-event="false"
        @cell-dblclick="canEdit ? $refs.vuecal.createEvent(
          $event,
          60 * 4,
          { title: 'Work', class: 'blue-event' }
        ) : null"
        @event-drop="updateEvent"
        @event-create="createEvent"
        @event-duration-change="updateEvent"
        @event-delete="deleteEvent"
        @view-change="editView"
        @ready="setupCal"
        >
      </VueCal>
      </div>
    </div>
  </ContainerLayout>
</template>

<script>
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'

import VueCal from 'vue-cal'
import 'vue-cal/dist/vuecal.css'
import { mapActions, mapGetters } from 'vuex'
import moment from 'moment'

export default {
  async mounted() {
    await this.fetchSchedule({u_id: this.givenUser.id, from: moment().subtract(2, "week").toISOString(), to: moment().add(2, "week").toISOString()})
    Object.values(this.watchedUser.schedule).forEach(ev => {
      const calEv = this.$refs.vuecal.createEvent(ev.start, ev.duration, {title: ev.title})
      this.eidToId[calEv._eid] = ev.id
    })
  },
  props: {
      givenUser: {},
  },
  data() {
    return {
      eidToId: {},
      startDate: null,
      endDate: null
    }
  },
  components: { ContainerLayout, VueCal },
  computed: {
    ...mapGetters({
      watchedUser: "watchedUser/getUser",
      currentUser: "currentUser/getUser"
    }),
    canEdit() {
      return (this.currentUser.role === "manager" || this.currentUser.role === "general_manager") && this.watchedUser.role === "employee"
    }
  },
  methods: {
    ...mapActions({
      createScheduleEvent: 'watchedUser/createScheduleEvent',
      fetchSchedule: "watchedUser/fetchSchedule",
      updateScheduleEvent: 'watchedUser/updateScheduleEvent',
      deleteScheduleEvent: 'watchedUser/deleteScheduleEvent'
    }),
    async setupCal({startDate, endDate}) {
      console.log("ready")
      this.startDate = startDate
      this.endDate = endDate
    },
    async editView({startDate, endDate}) {
      if(startDate === this.startDate) {
        this.endDate = endDate
      } else if (endDate === this.endDate) {
        this.startDate = startDate
      }
      await this.fetchSchedule({u_id: this.givenUser.id, from: moment(this.startDate).subtract(1, "week"), to: moment(this.endDate).add(1, "week")})
    },
    async createEvent(event) {
      this.roundToHalf(event.start)
      this.roundToHalf(event.end)
      await this.createScheduleEvent({u_id: this.givenUser.id, ...event})
      return event
    },
    async updateEvent({event}) {
      this.roundToHalf(event.start)
      this.roundToHalf(event.end)
      await this.updateScheduleEvent({u_id: this.givenUser.id, ev_id: this.eidToId[event._eid], ...event})
    },
    async deleteEvent(event) {
      await this.deleteScheduleEvent(this.eidToId[event._eid])
    },
    roundToHalf(date) {
      let m = date.getMinutes()
      date.setSeconds(0)
      if(m < 15) {
        date.setMinutes(0)
      } else if (m > 30) {
        date.setMinutes(0)
        date.setHours(date.getHours() + 1)
      } else if (m > 15){
        date.setMinutes(30)
      }
      return date
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/styles/colors.scss";
  .container {
    background-color: $khaki;
  border-radius: 12px;

    .user-schedule {
      min-height: 500px;
      display: flex;
      flex-direction: column;
      .header {
        text-align: center;
        font-weight: bold;
        font-size: 1.2em;
      }
      .calendar-container {
        height: 600px;
      }
    }
  }
</style>