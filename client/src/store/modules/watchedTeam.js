import axios from 'axios'

const API_URL= process.env.VUE_APP_AWS_DNS_NAME || 'http://localhost:4000/api'


const getDefaultState = () => ({
  id: null,
  name: null,
  startOfDay: null,
  endOfDay: null,
  users: [],
  totalNormalHours: null,
  totalOvertimeHours: null,
  totalNightHours: null
})

const watchedTeam = {
  namespaced: true,
  state: () => (getDefaultState()),
  mutations: {
    setTeam(state, team) {
      state.id = team.id
      state.name = team.name
      state.startOfDay = team.startOfDay
      state.endOfDay = team.endOfDay
    },
    setTeamUsers(state, users) {
      state.users = users
    }
  },
  actions: {
    async fetchTeam({commit, dispatch}, id) {
      try {
        const {data, status} = await axios.get(`${API_URL}/teams/${id}`)
        commit('setTeam', data)
        await dispatch('fetchTeamUsers')
        return {status}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async fetchTeamUsers({commit, state}) {
      try {
        const {data, status} = await axios.get(`${API_URL}/teams/${state.id}/users`)
        commit('setTeamUsers', data)
        return {status}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    }
  },
  getters: {
    getTeam(state) {
      return state
    }
  }
}

export default watchedTeam