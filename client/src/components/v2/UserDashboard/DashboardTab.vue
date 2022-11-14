<template>
  <ContainerLayout>
    <div class="dashboard-tab">
      <div class="row">
        <div class="header">
          <span>
            {{ user.username }}'s dashboard | 
          </span>
          <span>{{ name }} should be paid {{ watchedUser.salary }}$ this month.</span>
        </div>
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
      </div>
    </div>

    <div :class="{ bounce: disabled, clock: true }" @click="sendClock" v-if="showClock">
      <span>Clock {{ clocked ? 'out' : 'in' }}</span>
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
      ],
      disabled: false
    }
  },
  computed: {
    ...mapGetters({
      watchedUser: "watchedUser/getUser",
      currentUser: "currentUser/getUser"
    }),
    clocked() {
      return this.currentUser.clocks[this.currentUser.clocks.length - 1]?.status
    },
    showClock() {
      return this.currentUser.id === this.watchedUser.id
    },
    name() {
      return this.currentUser.id === this.watchedUser.id ? "You" : this.watchedUser.username
    }
  },
  methods: {
    ...mapActions({
      fetchHoursWorked: 'watchedUser/fetchHoursWorked',
      sendClockAction: 'currentUser/sendClock'
    }),
    async sendClock() {
      this.warnDisabled()
      const res = await this.sendClockAction(!this.clocked)
      if (res.data.hours_worked) {
        this.updateGraphData(Object.values(this.watchedUser.hours_worked))
      }
    },
    async fetchNewValues() {
      const res = await this.fetchHoursWorked({
        u_id: this.user.id,
        from: this.range[0],
        to: this.range[1]
      })
      if (res.status === 200) {
        this.updateGraphData(Object.values(this.watchedUser.hours_worked))
    }
  },
    async updateRange(range) {
      this.range = [moment(range[0]).format("YYYY-MM-DD"), moment(range[1]).format("YYYY-MM-DD")]
      await this.fetchNewValues()
    },
    updateGraphData(graphData) {
      const {data, labels} = sortedUserDaily(graphData)
        const summed = summedUserDaily(graphData)
        this.graph.perDay.sorted = data
        this.graph.perDay.summed = summed
        this.graph.perDay.labels = labels

        const {weekData, weekLabels} = sortedUserWeekly(graphData)
        const weekSummed = summedUserWeekly(graphData)
        this.graph.perWeek.sorted = weekData
        this.graph.perWeek.summed = weekSummed
        this.graph.perWeek.labels = weekLabels
        this.update++

    },
    warnDisabled() {
      this.disabled = true
      setTimeout(() => {
        this.disabled = false
      }, 1500)
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

.clock {
  cursor: pointer;
  background-color: $green;
  color: white;
  font-size: 2em;
  padding: 8px;
  width: fit-content;
  margin: auto;
  border-radius: 6px;
  transition: all 200ms ease;
  &:hover {
    box-shadow: 3px 3px 0px 0px darken($green, 20%);
  }
}
.bounce {
  animation: bounce 0.8s ease-in-out;
}

@keyframes bounce {
    0% { transform: scale(1.0); }
   10% { transform: scale(1.2); }
   20% { transform: scale(1.3); }
   30% { transform: scale(1.2); }
   40% { transform: scale(1.0); }
   50% { transform: scale(1.1); }
   60% { transform: scale(1.0); }
   70% { transform: scale(1.05);}
   80% { transform: scale(1.0); }
   90% { transform: scale(1.02);}
  100% { transform: scale(1.0); }
}
</style>
