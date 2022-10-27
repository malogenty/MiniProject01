<template>
  <div class="chart">
    <h1>Chart</h1>
    <BarChart :data="chartData"/>
  </div>
</template>

<script>
import BarChart from '../components/BarChart.vue'
import fakeWorkingTimes from '../dummies/fakeWorkingTimes.json'
import { getDayDurationsByWeeks } from '../utils/workingtimes_utils.js'
export default {
  name: 'HomeView',
  components: {
    BarChart
  },
  data() {
    return {
      chartData: getDayDurationsByWeeks(fakeWorkingTimes)['43']
    }
  }

}
</script>
