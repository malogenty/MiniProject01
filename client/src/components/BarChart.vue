<template>
  <Bar
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    :width="width"
    :height="height"
  />
</template>

<script>
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'BarChart',
  components: { Bar },
  props: {
    data: {
      type: Object,
      required: true
    },
    dataLabel: {
      type: String,
      required: true
    },
    chartId: {
      type: String,
      default: 'bar-chart'
    },
    datasetIdKey: {
      type: String,
      default: 'label'
    },
    width: {
      type: Number,
      default: 300
    },
    height: {
      type: Number,
      default: 100
    }
  },
  data() {
    return {
      chartData: {
        labels: this.getKeys(this.data),
        datasets: [{
          label: this.dataLabel,
          backgroundColor: '#236DC9',
          data: this.getValues(this.data)
        }]
      },
      chartOptions: {
        responsive: true
      }
    }
  },
  methods: {
    getKeys(obj) {
      return Object.keys(obj)
    },
    getValues(obj) {
      return Object.values(obj)
    }
  },
}
</script>