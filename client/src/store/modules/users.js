import axios from 'axios'
const API_URL='http://localhost:4000/api'

const users = {
  namespaced: true,
  state: () => ({
    users: []
  }),
  mutations: {
    updateUsers(state, users) {
      state.users = users
    },
    createUser(state, user) {
      state.users.push(user)
    }
  },
  actions: {
    async fetchAllUsers({commit}) {
      try {
        const {data} = await axios.get(`${API_URL}/users`)
        commit('updateUsers', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async createUser({commit}, {username, email}) {
      try {
        const {data, status} = await axios.post(`${API_URL}/users`, {user: {username, email}})
        commit('createUser', data)
        return {status}
      } catch({response}) {
        return {status: response.status}
      }
    }
  },
  getters: {
    getAllUsers(state) {
      return state.users
    }
  }
}

export default users