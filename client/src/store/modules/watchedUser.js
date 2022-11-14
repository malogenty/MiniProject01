import router from '@/router'
import axios from 'axios'
import moment from 'moment'


const API_URL= process.env.VUE_APP_AWS_DNS_NAME || 'http://localhost:4000/api'


const getDefaultState = () => ({
  id: null,
  username: null,
  email: null,
  role: null,
  hourRate: null,
  hours_worked: {},
  clocks: [],
  schedule: {},
  team: {},
  salary: null
})

const watchedUser = {
  namespaced: true,
  state: () => (getDefaultState()),
  mutations: {
    resetUser(state) {
      Object.assign(state, getDefaultState())
    },
    setUser(state, {id, username, email, role, hour_rate}) {
      state.id = id
      state.username = username
      state.email = email
      state.role = role
      state.hourRate = hour_rate
    },
    setTeam(state, team) {
      state.team = team
    },
    setHoursWorked(state, hours_worked_array) {
      hours_worked_array.forEach(hw => state.hours_worked[hw.date] = hw)
    },
    setSalary(state, salary) {
      state.salary = salary
    },
    setSchedules(state, events) {
      events.forEach(ev => state.schedule[ev.id] = ev)
    },
    addEvent(state, event) {
      state.schedule[event.id] = event
    },
    editEvent(state, event) {
      state.schedule[event.id] = event
    },
    deleteEvent(state, ev_id) {
      state.schedule[ev_id] = null
    },
    addSingleDay(state, hw) {
      state.hours_worked[hw.date] = hw
    }
  },
  actions: {
    resetUser({commit}) {
      commit('resetUser')
    },
    async fetchUser({commit, dispatch}, id) {
      commit('resetUser')
      try {
        const {data, status} = await axios.get(`${API_URL}/users/${id}`)
        commit('setUser', data)
        dispatch('getSalary')
        return {status}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async getSalary({commit, getters, dispatch}) {
      const user = getters.getUser
      const today = moment().format("YYYY-MM-DD")
      const startOfMonth = moment().startOf('month').format('YYYY-MM-DD')
      await dispatch('fetchTeam')
      await dispatch('fetchHoursWorked', {u_id: user.id, from: startOfMonth, to: today})
      let salary = 0
      for (const hw of Object.values(user.hours_worked)) {
        salary += hw.night_hours * user.team.nightMultiplicator * user.hourRate
        salary += hw.normal_hours * user.hourRate
        salary += hw.overtime_day * user.team.overtimeMultiplicator * user.hourRate
        salary += hw.overtime_night * (user.team.nightMultiplicator + user.team.overtimeMultiplicator) * user.hourRate
      }
      commit('setSalary', salary)
    },
    async fetchTeam({commit, getters}) {
      const {data, status} = await axios.get(`${API_URL}/users/${getters.getUser.id}/teams`)
      commit('setTeam', data[0])
      return {status, team: data}
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
        const {data, status} = await axios.get(`${API_URL}/hoursworked/${u_id}?from=${from}&to=${to}`)
        commit('setHoursWorked', data)
        return {status, data}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    addHoursWorked({commit}, data) {
      const arr = Array.isArray(data)
      if (arr) return commit('setHoursWorked', data)
      return commit('addSingleDay', data)
    },
    async fetchSchedule({commit}, {u_id, from, to}) {
      const {status, data} = await axios.get(`${API_URL}/schedule/${u_id}?start=${from}&end=${to}`)
        commit('setSchedules', data)
        return {status}
    },
    async createScheduleEvent({commit}, {title, start, duration, u_id }) {
      start = moment(start).toISOString(true) // keep the local time
      const {status, data} = await axios.post(`${API_URL}/schedule/${u_id}`, {schedule: {title: title.toLowerCase(), start, duration}})
      commit('addEvent', data)
      return {status}
    },
    async updateScheduleEvent({commit}, {ev_id, title, start, duration}) {
      start = moment(start).toISOString(true) // keep the local time
      const {status, data} = await axios.put(`${API_URL}/schedule/${ev_id}`, {schedule: {title: title.toLowerCase(), start, duration}})
      commit('editEvent', data)
      return {status}
    },
    async deleteScheduleEvent({commit}, id) {
      const {status} = await axios.delete(`${API_URL}/schedule/${id}`)
      commit('deleteEvent', id)
      return {status}
    },
    async customClockOut({getters}, clockOutTime) {
      clockOutTime = moment(clockOutTime).toISOString()
      const {data, status} = await axios.post(`${API_URL}/clocks/${getters.getUser.id}?clock_out=${clockOutTime}`)
      
      return {status, data}
    }
  },
  getters: {
    getUser(state) {
      return state
      
    }
  }
}


export default watchedUser