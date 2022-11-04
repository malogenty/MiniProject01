<template>
  <ContainerLayout>
    <div class="dashboard-tab">
      <span class="header">{{user.username}}'s dashboard</span>
      <select v-model="selected">
        <option disabled value="">Please select one</option>
        <option value="perDay">Hours worked per day</option>
        <option value="perWeek">Hours worked per week</option>
      </select>
      <div class="date-picker">
        <DatePicker @dateChange="updateRange"/>
      </div>
      <div class="dashboard-grid">
        <div class="graph one">
          <span class="title">Total hours worked</span>
          <LineChart :datas="graph[selected].summed" :labels="graph[selected].labels" dataLabel="test" :key="update"/>
        </div>
        <div class="graph two">
          <span class="title">Sorted hours worked</span>
          <BarChart :datas="graph[selected].sorted" :labels="graph[selected].labels" dataLabel="test" :key="update"/>
        </div>
        <div class="clock"><span>Clock in</span></div>
      </div>
    </div>
  </ContainerLayout>
</template>

<script>
import BarChart from '@/components/v2/Charts/BarChart.vue'
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'
import LineChart from '@/components/v2/Charts/LineChart.vue'
import DatePicker from '@/components/v2/UserDashboard/DatePicker.vue'
import { sortedData, summedData } from '@/utils/hoursworked_utils'

import moment from 'moment'
import { mapActions } from 'vuex'

export default {
  props: {
    givenUser: {}
  },
  components: {
    ContainerLayout,
    LineChart,
    BarChart,
    DatePicker
},
async created() {
  await this.fetchNewValues()
},
  data() {
    return {
      user: this.givenUser,
      selected: "perDay",
      update: 0,
      graph: {
        perDay: {
          sorted: [],
          summed: [],
          labels: []
        },
        perWeek: {
          data: {}
        }
      },
      range: [
        moment().subtract(1, "month").format("YYYY-MM-DD"),
        moment().format("YYYY-MM-DD")
      ]
    }
  },
  methods: {
    ...mapActions({
      fetchHoursWorked: 'watchedUser/fetchHoursWorked'
    }),
    async updateRange(range) {
      console.log(range)
      this.range = [moment(range[0]).format("YYYY-MM-DD"), moment(range[1]).format("YYYY-MM-DD")]
      await this.fetchNewValues()
    },
    async fetchNewValues() {
      const res = await this.fetchHoursWorked({u_id: this.user.id, from: this.range[0], to: this.range[1]})
      if(res.status === 200) {
        const {data, labels} = sortedData(res.data)
        const summed = summedData(res.data)
        this.graph.perDay.sorted = data
        this.graph.perDay.summed = summed
        this.graph.perDay.labels = labels
      }
      this.update++
    },
    
  }
}
</script>



<style scoped lang="scss">
@import "@/styles/colors.scss";
.container {
  background: $blue;
  border-radius: 12px;
  .dashboard-tab {
    min-height: 500px;
    display: flex;
    flex-direction: column;
    .header {
      text-align: center;
      font-weight: bold;
      font-size: 1.2em;
    }
    select {
      width: min-content;
      margin: 12px auto;
    }
    .date-picker {
      margin: auto;
    }
    .dashboard-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-template-rows: repeat(2, 1fr);
      height: 100%;
      margin-top: 12px;
      gap: 12px;
      .graph {
        height: 300px;
        width: 600px;
        background-color: $beige;
        margin: 0 auto;
        padding: 12px;
        border-radius: 4px;
        .title {
          display: block;
          text-align: center;
          font-weight: bold;
        }
        &.one {
          grid-area: 1 / 1 / 2 / 2;
        }
        &.two {
        grid-area: 1 / 2 / 2 / 3;
      }
      }
      .clock {
        margin: auto;
        grid-area: 2 / 1 / 3 / 3;
        background-color: $beige;
        width: 33%;
        height: 33%;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        span {
          font-size: 3em;
          font-weight: bold;
          text-transform: uppercase;
        }
      }
    }
  }
}
</style>