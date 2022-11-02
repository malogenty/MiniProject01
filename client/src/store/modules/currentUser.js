import axios from 'axios'


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
    updateUser (state, {id, username, email, role, hour_rate}) {
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
    async login({commit, dispatch}, {id}) {
      try {
        const {data, status} = await axios.get(`${API_URL}/users/${id}`)
        commit ('updateUser', data)
        if(data.role === 'manager' || data.role === 'general_manager') dispatch('fetchTeams')
        return {status};
      } catch({response}) {
        return {error: response.data.error, status: response.status}
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