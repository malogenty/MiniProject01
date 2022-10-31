<template>
  <div class="chart-vue"  v-if="!loading">
      <select v-model="selected">
        <option disabled value="">Please select one</option>
        <option value="daysData">days</option>
        <option value="weekData">weeks</option>
        <option value="averageWeekData">Average weeks</option>
      </select>
      
      <h2>{{ result[selected].text }}</h2>
      <div class="charts">
        <div class="chart">
          <LineChart
          :key="result[selected].label"
          :data="result[selected].data"
          dataLabel="Heures de Travail"
          />
        </div>
        <div class="chart">
          <BarChart
          :key="result[selected].label"
          :data="result[selected].data"
          dataLabel="Heures de travail"
          />
        </div>
          <div class="chart">
            <DoughnutChart
            :key="result[selected].label"
            :data="result[selected].data"
            dataLabel="Heures de travail"/>
          </div>
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
import BarChart from '../BarChart.vue'
import DoughnutChart from '../DoughnutChart.vue'
export default {
  name: 'HomeView',
  components: {
    LineChart,
    BarChart,
    DoughnutChart
  },
  async created()
   {
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
  .chart-vue {
    display: flex;
    flex-direction: column;
    select {
      width: min-content;
    }
    .charts {
      height: 100%;
      display: flex;
      gap: 1vw;
      width: 100%;
      align-items: flex-end;
      .chart {
        width: 33%;
        height: 100%;
        display: flex;
        justify-content: center;
        > div {
          max-width: 100%;
        }
      }
    }
  }
</style>