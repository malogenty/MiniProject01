<template>
  <div class="chart">
    <NavBar
    :fullscreen="fullscreen"
    @toggleFullScreen="$emit('toggleFullScreen')"
    :user="user"
    />
    <h1>Charts</h1>
    <select v-model="selected">
      <option disabled value="">Please select one</option>
      <option value="daysData">days</option>
      <option value="weekData">weeks</option>
      <option value="averageWeekData">Average weeks</option>
    </select>

    <h2>{{ result[selected].text }}</h2>
      <LineChart
      :key="result[selected].label"
      :data="result[selected].data"
      dataLabel="Heures de Travail"
      />
  </div>
</template>

<script>
import moment from 'moment'
import LineChart from '@/components/LineChart.vue'
import NavBar from '@/components/Dashboard/NavBar.vue'
import {
  getDayDurationsByWeeks,
  getDurationByWeeks,
  getAverageDurationByWeeks
} from '@/utils/workingtimes_utils.js'
import { mapActions, mapGetters } from 'vuex'
export default {
  name: 'HomeView',
  components: {
    LineChart,
    NavBar
  },
  async created() {
    await this.fetchWorkingTimesStartEnd({start: moment().subtract(1, 'week'), end: moment()})
    this.user = this.getUser
    this.result.daysData.data = getDayDurationsByWeeks(this.user.workingTimes)['43']
    this.result.weekData.data = getDurationByWeeks(this.user.workingTimes)
    this.result.averageWeekData.data = getAverageDurationByWeeks(this.user.workingTimes)

  },
  props: {
    fullscreen: Boolean
  },
  computed: {
    ...mapGetters({
      user: 'currentUser/getUser'
    })
  },
  data() {
    return {
      selected: 'weekData',
      result: {
        daysData: {
          data: [],
          text: 'Heures de travail par jour',
          label: 'par jour',
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)'
        },
        weekData: {
          data: [],
          text: 'Heures de travail par semaine',
          label: 'par semaine',
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)'
        },
        averageWeekData: {
          data: [],
          text: 'Moyenne des heures de travail par semaine',
          label: 'moyenne par semaine',
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)'
        }
      }
    }
  },
  methods: {
    ...mapActions({
      fetchWorkingTimesStartEnd: 'currentUser/fetchWorkingTimesStartEnd'
    })
  }
}
</script>

<style scoped lang="scss">
  .chart {
    height: 100%;
  }
</style>