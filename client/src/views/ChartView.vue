<template>
  <div class="chart">
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
import LineChart from '../components/LineChart.vue'
import fakeWorkingTimes from '../dummies/fakeWorkingTimes.json'
import {
  getDayDurationsByWeeks,
  getDurationByWeeks,
  getAverageDurationByWeeks
} from '../utils/workingtimes_utils.js'
export default {
  name: 'HomeView',
  components: {
    LineChart
  },
  data() {
    return {
      selected: 'weekData',
      result: {
        daysData: {
          data: getDayDurationsByWeeks(fakeWorkingTimes)['43'],
          text: 'Heures de travail par jour',
          label: 'par jour',
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)'
        },
        weekData: {
          data: getDurationByWeeks(fakeWorkingTimes),
          text: 'Heures de travail par semaine',
          label: 'par semaine',
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)'
        },
        averageWeekData: {
          data: getAverageDurationByWeeks(fakeWorkingTimes),
          text: 'Moyenne des heures de travail par semaine',
          label: 'moyenne par semaine',
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)'
        }
      }
    }
  }
}
</script>
