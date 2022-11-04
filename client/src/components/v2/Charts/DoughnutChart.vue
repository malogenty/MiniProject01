<template>
  <Doughnut
    :chart-options="chartOptions"
    :chart-data="chartData"
    :chart-id="chartId"
    :dataset-id-key="datasetIdKey"
    v-if="hasData"
  />
  <div class="canvas-wrapper" v-else>
    Sorry, no data to display.
  </div>
</template>

<script>
import { Doughnut } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  CategoryScale,
} from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)

export default {
  name: 'BarChart',
  components: { Doughnut },
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
  computed: {
    hasData() {
      return Object.values(this.data).length > 0
    }
  }
}
</script>
