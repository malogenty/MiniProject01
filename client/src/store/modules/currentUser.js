import axios from 'axios'
import VueCookies from 'vue-cookies'
import router from '@/router'

const API_URL = process.env.VUE_APP_AWS_DNS_NAME || 'http://localhost:4000/api'


const getDefaultState = () => ({
  id: null,
  username: null,
  email: null,
  role: null,
  clocks: [],
  teams: []
})

const currentUser = {
  namespaced: true,
  state: () => (getDefaultState()),
  mutations: {
    resetState (state) {
      Object.assign(state, getDefaultState())
    },
    setUser (state, {id, username, email, role, hour_rate}) {
      state.id = id
      state.username = username
      state.email = email
      state.role = role
      state.hourRate = hour_rate
    },
    updateTeams(state, teams) {
      state.teams = teams
    },
    setClocks(state, clocks) {
      state.clocks = clocks
    },
    addClock(state, clock) {
      state.clocks.push(clock)
    }
  },
  actions: {
    async login({commit, dispatch}, {username, password}) {
      try {
        commit('resetState')
        let str = btoa(`${username}:${password}`)
        const {data, status} = await axios.get(`${API_URL}/users`, {headers: {Authorization: `Basic: ${str}`}})
        commit('setUser', data)
        VueCookies.set("jwt", data.token, 60 * 60 * 2, null, null, true, "Lax")
        axios.defaults.headers.common["Authorization"] = `Bearer: ${data.token}`
        if (data.role === "general_manager" || data.role === "manager") dispatch('fetchTeams')
        dispatch('fetchClocks')
        return {status}
      } catch({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async tokenLogin({commit, dispatch}) {
      const token = VueCookies.get("jwt")
      if (!token) return false
      try {
        axios.defaults.headers.common["Authorization"] = `Bearer: ${token}`
        commit('resetState')
        const {data, status} = await axios.get(`${API_URL}/users`)
        commit('setUser', data)
        if (data.role === "general_manager" || data.role === "manager") dispatch('fetchTeams')
        dispatch('fetchClocks')
        return {status}
      } catch({response}) {
        return {error: response.error, status: response.status}
      }
    },
    logout({commit, dispatch}) {
      VueCookies.remove("jwt")
      commit('resetState')
      dispatch('watchedUser/resetUser', null, {root: true})
      axios.defaults.headers.common["Authorization"] = null
      router.push('/login')
    },
    async fetchTeams({commit, getters}) {
      try {
        const {data, status} = await axios.get(`${API_URL}/users/${getters.getUser.id}/teams`)
        commit('updateTeams', data)
        return {status}
      } catch ({response}) {
        return {error: response.data.error, status: response.status}
      }
    },
    async editUser({commit, getters}, user) {
      const token = VueCookies.get("jwt")
      try {
        const {data, status} = await axios.put(`${API_URL}/users/${getters.getUser.id}`, {user: {...user, token}})
        commit('setUser', data)
        return {status}
      } catch ({response}) {
        return {error: response.data.error, status: response.status}
      }
    },
    async fetchClocks({commit, getters}) {
      const {data, status} = await axios.get(`${API_URL}/clocks/${getters.getUser.id}`)
      commit('setClocks', data)
      return {status}
    },
    async sendClock({getters, commit, rootGetters, dispatch}, clockStatus) {
      const {data, status} = await axios.post(`${API_URL}/clocks/${getters.getUser.id}`, {status: clockStatus})
      const watchedUser = rootGetters["watchedUser/getUser"]
      if (data.hours_worked && watchedUser.id == getters.getUser.id) dispatch('watchedUser/addHoursWorked', data.hours_worked, {root: true})
      
      commit('addClock', data.clock)
      return {status, data}
    }
   },
  getters: {
    getUser(state) {
      return state
    }
  }
}

export default currentUser