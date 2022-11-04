import axios from 'axios'
import VueCookies from 'vue-cookies'


const API_URL='http://localhost:4000/api'

const getDefaultState = () => ({
  id: null,
  username: null,
  email: null,
  role: null,
  hourRate: null,
  hoursWorked: [],
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
    }
  },
  actions: {
    logout({commit}) {
      commit('resetState')
    },
    async login({commit, dispatch}, {username, email}) {
      try {
        commit('resetState')
        const {data, status} = await axios.get(`${API_URL}/users?username=${username}&email=${email}`)
        commit('setUser', data)
        VueCookies.set("jwt", data.token, 60 * 60 * 2, null, null, true, "Lax")
        axios.defaults.headers.common["Authorization"] = data.token
        if (data.role === "general_manager" || data.role === "manager") dispatch('fetchTeams')
        return {status}
      } catch({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async tokenLogin({commit, dispatch}) {
      const token = VueCookies.get("jwt")
      if (!token) return false
      try {
        axios.defaults.headers.common["Authorization"] = token
        commit('resetState')
        const {data, status} = await axios.get(`${API_URL}/users`)
        commit('setUser', data)
        if (data.role === "general_manager" || data.role === "manager") {
          console.log("manager or gen manager")
          dispatch('fetchTeams')}
        return {status}
      } catch({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async fetchTeams({commit, state}) {
      try {
        const {data, status} = await axios.get(`${API_URL}/users/${state.id}/teams`)
        commit('updateTeams', data)
        return {status}
      } catch ({response}) {
        return {error: response.data.error, status: response.status}
      }
    }
  },
  getters: {
    getUser(state) {
      return state
    }
  }
}

export default currentUser