<template>
  <div class="chart">
    <h1>Chart</h1>
    <BarChart :data="daysData" />
    <LineChart :data="daysData" />
  </div>
</template>

<script>
import BarChart from '../components/BarChart.vue'
import LineChart from '../components/LineChart.vue'
import fakeWorkingTimes from '../dummies/fakeWorkingTimes.json'
import {
  getDayDurationsByWeeks,
  getDurationByWeeks
} from '../utils/workingtimes_utils.js'
export default {
  name: 'HomeView',
  components: {
    BarChart,
    LineChart
  },
  data() {
    return {
      daysData: getDayDurationsByWeeks(fakeWorkingTimes)['43'],
      weekData: getDurationByWeeks(fakeWorkingTimes)
    }
  }
}
</script>
