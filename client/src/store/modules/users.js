import axios from 'axios'

const users = {
  namespaced: true,
  state: () => ({
    users: []
  }),
  mutations: {
    updateUsers(state, users) {
      state.users = users
    }
  },
  actions: {
    async fetchAllUsers({commit}) {
      try {
        const {data} = await axios.get(`http://localhost:4000/api/users`)
        commit('updateUsers', data)
      } catch(e) {
        throw new Error(e)
      }
    },
  }
}

export default users