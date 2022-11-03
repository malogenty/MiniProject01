import axios from 'axios'


const API_URL='http://localhost:4000/api'

const getDefaultState = () => ({
  id: null,
  username: null,
  email: null,
  workingTimes: {},
  clocks: {}
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

    }
  },
  getters: {
    getUser(state) {
      return state
    }
  }
}

export default watchedUser