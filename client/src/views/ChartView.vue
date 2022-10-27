<template>
  <div class="chart">
    <h1>Charts</h1>

    <h2>Nombre d'heures de travail par jour</h2>
    <BarChart :data="daysData" dataLabel="Heures de Travail" />

    <h2>Nombre d'heures de travail par semaine</h2>
    <LineChart :data="weekData" dataLabel="Heures de Travail" />
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
