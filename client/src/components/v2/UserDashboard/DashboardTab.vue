<template>
  <ContainerLayout>
    <div class="dashboard-tab">
      <div class="row">
        <span class="header">{{ user.username }}'s dashboard</span>
        <div class="date-picker">
          <DatePicker @dateChange="updateRange" />
        </div>
        <select v-model="selected">
          <option disabled value="">Please select one</option>
          <option value="perDay">Hours worked per day</option>
          <option value="perWeek">Hours worked per week</option>
        </select>
      </div>

      <div class="dashboard-grid">
        <div class="graph one">
          <span class="title">Total hours worked</span>
          <LineChart
            :datas="graph[selected].summed"
            :labels="graph[selected].labels"
            dataLabel="test"
            :key="update"
          />
        </div>
        <div class="graph two">
          <span class="title">Sorted hours worked</span>
          <BarChart
            :datas="graph[selected].sorted"
            :labels="graph[selected].labels"
            dataLabel="test"
            :key="update"
          />
        </div>
        <div class="clock" @click="sendClock">
          <span>Clock {{ clocked ? 'out' : 'in' }}</span>
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
import {
  sortedUserDaily,
  summedUserDaily,
  sortedUserWeekly,
  summedUserWeekly
} from '@/utils/hoursworked_utils'

import moment from 'moment'
import { mapActions, mapGetters } from 'vuex'

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
      selected: 'perDay',
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
        moment().subtract(1, 'month').format('YYYY-MM-DD'),
        moment().format('YYYY-MM-DD')
      ]
    }
  },
  computed: {
    ...mapGetters({
      watchedUser: 'watchedUser/getUser'
    }),
    clocked() {
      return this.watchedUser.clocks[this.watchedUser.clocks.length - 1]?.status
    }
  },
  methods: {
    ...mapActions({
      fetchHoursWorked: 'watchedUser/fetchHoursWorked',
      sendClockAction: 'currentUser/sendClock'
    }),
    async sendClock() {
      await this.sendClockAction()
    },
    async updateRange(range) {
      console.log(range)
      this.range = [
        moment(range[0]).format('YYYY-MM-DD'),
        moment(range[1]).format('YYYY-MM-DD')
      ]
      await this.fetchNewValues()
    },
    async fetchNewValues() {
      const res = await this.fetchHoursWorked({
        u_id: this.user.id,
        from: this.range[0],
        to: this.range[1]
      })
      if (res.status === 200) {
        const { data, labels } = sortedUserDaily(res.data)
        const summed = summedUserDaily(res.data)
        this.graph.perDay.sorted = data
        this.graph.perDay.summed = summed
        this.graph.perDay.labels = labels

        const { weekData, weekLabels } = sortedUserWeekly(res.data)
        const weekSummed = summedUserWeekly(res.data)
        this.graph.perWeek.sorted = weekData
        this.graph.perWeek.summed = weekSummed
        this.graph.perWeek.labels = weekLabels
      }
      this.update++
    }
  },
  watch: {
    selected() {
      this.update++
    }
  }
}
</script>

<style scoped lang="scss">
@import '@/styles/colors.scss';
.dashboard-tab {
  background-color: $light_grey;
  display: flex;
  flex-direction: column;
  margin-bottom: 2vw;
  padding: 2%;
  border-radius: 10px;

  .row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .header {
      font-weight: bold;
      font-size: 1.5em;
      margin: 0 auto 0 0;
    }
    select {
      width: min-content;
      border: none;
      background: none;
    }
    .date-picker {
      margin-right: 1%;
    }
  }
  .dashboard-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    height: 100%;
    width: 100%;
    margin-top: 5%;
    gap: 3%;
    .graph {
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
</style>
