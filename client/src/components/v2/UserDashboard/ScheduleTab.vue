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
        @cell-dblclick="canEdit ? createBasicEvent($event) : null"
        @event-drop="updateEvent"
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
    await this.fetchSchedule({u_id: this.givenUser.id, from: moment().subtract(2, "week").format("YYYY-MM-DD"), to: moment().add(2, "week").format("YYYY-MM-DD")})
    Object.values(this.watchedUser.schedule).forEach(ev => {
      const calEv = this.$refs.vuecal.createEvent(new Date(ev.start), ev.duration * 60, {title: ev.title})
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
      return (this.currentUser.role === "manager" && this.watchedUser.role === "employee") || (this.currentUser.role === "general_manager" && (this.watchedUser.role === "employee" || this.watchedUser.role === "manager"))
    }
  },
  methods: {
    ...mapActions({
      createScheduleEvent: 'watchedUser/createScheduleEvent',
      fetchSchedule: "watchedUser/fetchSchedule",
      updateScheduleEvent: 'watchedUser/updateScheduleEvent',
      deleteScheduleEvent: 'watchedUser/deleteScheduleEvent'
    }),
    async createBasicEvent (ev) {
      const event = this.$refs.vuecal.createEvent( ev, 240, { title: 'Work'})
      return this.createEventDB(event)
    },
    async setupCal({startDate, endDate}) {
      this.startDate = startDate
      this.endDate = endDate
    },
    async editView({startDate, endDate}) {
      if(startDate === this.startDate) {
        this.endDate = endDate
      } else if (endDate === this.endDate) {
        this.startDate = startDate
      }
      await this.fetchSchedule({u_id: this.givenUser.id, from: moment(this.startDate).subtract(1, "week").format("YYYY-MM-DD"), to: moment(this.endDate).add(1, "week").format("YYYY-MM-DD")})
    },
    async createEventDB(event) {
      this.roundToHalf(event.start)
      this.roundToHalf(event.end)
      console.log(event.start)
      const duration = moment(event.end).diff(event.start) / 1000 / 60
      await this.createScheduleEvent({u_id: this.givenUser.id, duration, ...event})
      return event
    },
    async updateEvent({event}) {
      this.roundToHalf(event.start)
      this.roundToHalf(event.end)
      const duration = moment(event.end).diff(event.start) / 1000 / 60
      await this.updateScheduleEvent({ev_id: this.eidToId[event._eid], duration, ...event})
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