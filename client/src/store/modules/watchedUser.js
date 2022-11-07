import router from '@/router'
import axios from 'axios'
import moment from 'moment'
const ARR = {
  1: {
    id: 1,
    title: "Work",
    start: moment().toDate(),
    duration: Math.abs(moment().diff(moment().add(5, "hour"))) / 60 / 1000
  },

  2: { 
    id: 2,
    title: "Work",
    start: moment().add(1, "day").toDate(),
    duration: Math.abs(moment().add(1, "day").diff(moment().add(1, "day").add(4, "hour"))) / 60 / 1000
  }
}

const API_URL= process.env.VUE_APP_AWS_DNS_NAME || 'http://localhost:4000/api'


const getDefaultState = () => ({
  id: null,
  username: null,
  email: null,
  role: null,
  hourRate: null,
  hours_worked: [],
  clocks: [],
  schedule: {}
})

const watchedUser = {
  namespaced: true,
  state: () => (getDefaultState()),
  mutations: {
    setUser(state, {id, username, email, role, hour_rate}) {
      state.id = id
      state.username = username
      state.email = email
      state.role = role
      state.hourRate = hour_rate
    },
    setHoursWorked(state, hw) {
      state.hours_worked = hw
    },
    setSchedules(state, schedule) {
      state.schedule = schedule
    }
  },
  actions: {
    async fetchUser({commit}, id) {
      try {
        const {data, status} = await axios.get(`${API_URL}/users/${id}`)
        commit('setUser', data)
        return {status}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async promoteUser({commit}, id) {
      try {
        const {data, status} = await axios.put(`${API_URL}/users/${id}/promote`)
        commit('setUser', data)
        return {status}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async deleteUser({rootGetters, dispatch, commit}, id) {
      const curr = rootGetters['currentUser/getUser']
      try {
        const {status} = await axios.delete(`${API_URL}/users/${id}`)
        if(curr.id === id) {
          dispatch('currentUser/logout', null, {root: true})
        } else {
          commit('resetState')
          router.back()
        }
        return {status}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async fetchHoursWorked({commit}, {u_id, from, to}) {
      try {
        let id = 1 || u_id
        const {data, status} = await axios.get(`${API_URL}/hoursworked/${id}/fromto?from=${from}&to=${to}`)
        commit('setHoursWorked', data)
        return {status, data}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    // eslint-disable-next-line no-unused-vars
    async fetchSchedule({commit}, {u_id, from, to}) {
      console.log("fetched schedule")
      // let id = 1 || u_id
      // const res= await axios.get(`${API_URL}/schedules/${id}/fromto?from=${from}&to=${to}`)
      // if (!res) {
        commit('setSchedules', ARR)
      // }
    },
    // eslint-disable-next-line no-unused-vars
    async createScheduleEvent({commit}, {title, start, end, u_id }) {
      console.log(u_id, start.getHours(), end.getHours(), title)
    },
    // eslint-disable-next-line no-unused-vars
    async updateScheduleEvent({commit}, {u_id, ev_id, title, start, end}) {
      console.log(u_id, start.getHours(), end.getHours(), title, ev_id)
    },
    // eslint-disable-next-line no-unused-vars
    async deleteScheduleEvent({commit}, id) {
      console.log(id)
    }
  },
  getters: {
    getUser(state) {
      return state
    }
  }
}


export default watchedUser