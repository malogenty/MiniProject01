import axios from 'axios'
import VueCookies from 'vue-cookies'
import router from '@/router'

const API_URL= process.env.AWS_DNS_NAME || 'http://localhost:4000/api'


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
    }
  },
  actions: {
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
          dispatch('fetchTeams')}
        return {status}
      } catch({response}) {
        return {error: response.error, status: response.status}
      }
    },
    logout({commit}) {
      VueCookies.remove("jwt")
      commit('resetState')
      axios.defaults.headers.common["Authorization"] = null
      router.push('/login')
    },
    async fetchTeams({commit, state}) {
      try {
        const {data, status} = await axios.get(`${API_URL}/users/${state.id}/teams`)
        commit('updateTeams', data)
        return {status}
      } catch ({response}) {
        return {error: response.data.error, status: response.status}
      }
    },
    async editUser({commit, state}, user) {
      const token = VueCookies.get("jwt")
      try {
        const {data, status} = await axios.put(`${API_URL}/users/${state.id}`, {user: {...user, token}})
        commit('setUser', data)
        return {status}
      } catch ({response}) {
        return {error: response.data.error, status: response.status}
      }
    },
    async sendClock() {
      // const {data, status} = await axios.post(`${API_URL}/clocks/${state.id}`)
    }
   },
  getters: {
    getUser(state) {
      return state
    }
  }
}

export default currentUser