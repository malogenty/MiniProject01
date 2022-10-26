import axios from 'axios'

const user = {
  namespaced: true,
  state: () => ({
    id: null,
    username: null,
    email: null
  }),
  mutations: {
    updateUser(state, {id, username, email}) {
      state.id = id
      state.username = username
      state.email = email
    }
  },
  actions: {
    async fetchUser({commit}, {id}) {
      try {
        const {data} = await axios.get(`http://localhost:4000/api/users/${id}`)
        commit('updateUser', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async updateUser({commit, state}, user) {
      try {
        const {data} = await axios.put(`http://localhost:4000/api/users/${state.id}`, {user})
        commit('updateUser', data)
      } catch(e) {
        throw new Error(e)
      }
    } 
  },
  getters: {
    getUser(state) {
      return state
    }
  }
}

export default user