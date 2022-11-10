import axios from 'axios'

const API_URL= process.env.VUE_APP_AWS_DNS_NAME || 'http://localhost:4000/api'

const getDefaultState = () => ({
  id: null,
  name: null,
  startOfDay: null,
  endOfDay: null,
  users: [],
  hoursWorked: []
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
    },
    setTeamHoursWorked(state, hw) {
      state.hoursWorked = hw
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
    },
    // eslint-disable-next-line no-unused-vars
    async fetchHoursWorked({commit}, {team_id, from, to}) {
      const {data, status} = await axios.get(`${API_URL}/hoursworked/teams/${team_id}?from=${from}&to=${to}`)
      commit('setTeamHoursWorked', data)
      return {status}
    }
  },
  getters: {
    getTeam(state) {
      return state
    }
  }
}

export default watchedTeam