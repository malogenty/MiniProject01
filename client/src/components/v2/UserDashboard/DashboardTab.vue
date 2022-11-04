<template>
  <ContainerLayout>
    <div class="dashboard-tab">
      <span class="header">{{user.username}}'s dashboard</span>
      <select v-model="selected" @change="handleChange">
        <option disabled value="">Please select one</option>
        <option value="perDay">Hours worked per day</option>
        <option value="perWeek">Hours worked per week</option>
      </select>
      <div class="date-picker">
        <DatePicker @dateChange="fetchNewValues"/>
      </div>
      <div class="dashboard-grid">
        <div class="graph one">
          <span class="title">Graph one</span>
          <LineChart :data="graph[0].data" dataLabel="test"/>
        </div>
        <div class="graph two">
          <span class="title">Graph two</span>
          <BarChart :data="graph[0].data" dataLabel="test"/>
        </div>
        <div class="clock"><span>Clock in</span></div>
      </div>
    </div>
  </ContainerLayout>
</template>

<script>
import BarChart from '@/components/BarChart.vue'
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'
import LineChart from '@/components/LineChart.vue'
import DatePicker from '@/components/v2/UserDashboard/DatePicker.vue'

import moment from 'moment'

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
  data() {
    return {
      user: this.givenUser,
      selected: "perDay",
      graph: [
        {
          data: {}
        },
        {
          data: {}
        }
      ],
      range: [
        moment().subtract(1, "month").format(),
        moment().format()
      ]
    }
  },
  computed: {
    isX() {
      return true
    }
  },
  methods: {
    async fetchNewValues(range) {
      this.range = [moment(range[0]).format(), moment(range[1]).format()]
    }
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