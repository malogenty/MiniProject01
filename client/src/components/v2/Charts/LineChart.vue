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
    datas: {
      type: Array,
      required: true
    },
    labels: {
      type: Array,
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
        labels: this.labels,
        datasets: [
          ...this.datas.map(data => ({
            label: data.label,
            backgroundColor: data.color,
            data: this.getValues(data.datas)
          }))
      ]
      },
      chartOptions: {
        responsive: true,
        aspectRatio: 600 | 400,
        maintainAspectRation: false,
        scale: {
          ticks: {
            precision: 0
          }
        }
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
      for(let data of this.datas) {
        if(Object.keys(data.datas).length > 0) return true
      }
      return false
    },

  }
}
</script>

<style scoped lang="scss">
.canvas-wrapper {
  height: 90%;
  &.no-data {
    display: flex;
    justify-content: center;
    align-items: center;
  }
}
</style>