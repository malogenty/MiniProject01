<template>
  <Line
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    :width="width"
    :height="height"
  />
</template>

<script>
import { Line } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  CategoryScale,
  LinearScale,
  PointElement
} from 'chart.js'

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  CategoryScale,
  LinearScale,
  PointElement
)

export default {
  name: 'LineChart',
  components: { Line },
  props: {
    data: {
      type: Object,
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
        datasets: [
          {
            label: 'Heures de travail',
            backgroundColor: '#236DC9',
            borderColor: '#236DC9',
            pointBackgroundColor: 'white',
            data: this.getValues(this.data),
            tension: 0.3
          }
        ]
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
  }
}
</script>
