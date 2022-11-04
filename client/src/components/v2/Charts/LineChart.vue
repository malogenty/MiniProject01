<template>
    <Line
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    cssClasses="canvas-wrapper"
    v-if="hasData"
    />
    <div class="canvas-wrapper no-data" v-else>
      Sorry, no data to display.
    </div>
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
      default: 200
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
            label: this.dataLabel,
            backgroundColor: '#236DC9',
            borderColor: '#236DC9',
            pointBackgroundColor: 'white',
            data: this.getValues(this.data),
            tension: 0.3
          }
        ]
      },
      chartOptions: {
        responsive: true,
        aspectRatio: 600 | 400,
        maintainAspectRatio: false
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
  computed: {
    hasData() {
      return Object.values(this.data).length > 0
    }
  }
}
</script>

<style scoped lang="scss">
.canvas-wrapper {
  width: 90%; 
  height: 90%; 
  margin: auto;
  &.no-data {
    display: flex;
    justify-content: center;
    align-items: center;
  }
}
</style>