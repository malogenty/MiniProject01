<template>
  <div class="chart">
    <div v-if="!loading">
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
  </div>
</template>

<script>
import moment from 'moment'
import LineChart from '@/components/LineChart.vue'
import {
  getDayDurationsByWeeks,
  getDurationByWeeks,
  getAverageDurationByWeeks
} from '@/utils/workingtimes_utils.js'
import { mapActions } from 'vuex'
export default {
  name: 'HomeView',
  components: {
    LineChart
  },
  async created() {
    await this.fetchWorkingTimesStartEnd({start: moment().subtract(1, 'week'), end: moment()})
    const currWeek = moment().week() - 1
    this.result.daysData.data = getDayDurationsByWeeks(this.user.workingTimes)[currWeek]
    this.result.weekData.data = getDurationByWeeks(this.user.workingTimes)
    this.result.averageWeekData.data = getAverageDurationByWeeks(this.user.workingTimes)
    this.loading = false
  },
  props: {
    fullscreen: Boolean,
    user: {}
  },
  data() {
    return {
      selected: 'weekData',
      loading: true,
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