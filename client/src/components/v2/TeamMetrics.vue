<template>
  <ContainerLayout>
    <div class="team-metrics">
      <span class="header">Team {{team.name}}'s dashboard</span>
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
      </div>
    </div>
  </ContainerLayout>
</template>

<script>
import BarChart from '@/components/v2/Charts/BarChart.vue'
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'
import LineChart from '@/components/v2/Charts/LineChart.vue'
import DatePicker from '@/components/v2/UserDashboard/DatePicker.vue'
import {dailyTeamAverage ,dailyTeamSortedAverage, weeklyTeamAverage, weeklyTeamSortedAverage} from '@/utils/hoursworked_utils'

import moment from 'moment'
import { mapActions, mapGetters } from 'vuex'

export default {
  props: {
    givenTeam: {}
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
      team: this.givenTeam,
      selected: "perDay",
      update: 0,
      graph: {
        perDay: {
          sorted: [],
          summed: [],
          labels: []
        },
        perWeek: {
          sorted: [],
          summed: [],
          labels: []
        }
      },
      range: [
        moment().subtract(1, "month").format("YYYY-MM-DD"),
        moment().format("YYYY-MM-DD")
      ]
    }
  },
  computed: {
    ...mapGetters({
      getTeam: "watchedTeam/getTeam"
    })
  },
  methods: {
    ...mapActions({
      fetchHoursWorked: 'watchedTeam/fetchHoursWorked'
    }),
    async updateRange(range) {
      this.range = [moment(range[0]).format("YYYY-MM-DD"), moment(range[1]).format("YYYY-MM-DD")]
      await this.fetchNewValues()
    },
    async fetchNewValues() {
      const res = await this.fetchHoursWorked({team_id: this.team.id, from: this.range[0], to: this.range[1]})
      if(res.status === 200) {
        const {data, labels} = dailyTeamSortedAverage(this.getTeam.hoursWorked)
        const summed = dailyTeamAverage(this.getTeam.hoursWorked)
        this.graph.perDay.sorted = data
        this.graph.perDay.summed = summed
        this.graph.perDay.labels = labels

        const {weekData, weekLabels} = weeklyTeamSortedAverage(this.getTeam.hoursWorked)
        const weekSummed = weeklyTeamAverage(this.getTeam.hoursWorked)
        this.graph.perWeek.sorted = weekData
        this.graph.perWeek.summed = weekSummed
        this.graph.perWeek.labels = weekLabels
      }
      this.update++
    },
    
  },
  watch: {
    selected() {
      this.update++
    }
  }
}
</script>



<style scoped lang="scss">
@import "@/styles/colors.scss";
.container {
  background: $blue;
  border-radius: 12px;
  margin-bottom: 2vw;
  .team-metrics {
    display: flex;
    flex-direction: column;
    margin-bottom: 2vw;
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
    }
  }
}
</style>