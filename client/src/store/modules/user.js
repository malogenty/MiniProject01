import axios from 'axios'

const user = {
  namespaced: true,
  state: () => ({
    id: null,
    username: null,
    email: null,
    workingTimes: [],
    clocks: []
  }),
  mutations: {
    updateUsername(state, {username}) {
      state.username = username
    },
    updateEmail(state, {email}) {
      state.email = email
    },
    updateWorkingtimes(state, {workingTimes}) {
      state.workingTimes = workingTimes
    },
    updateClocks(state, {clocks}) {
      state.clocks = clocks
    }
  },
  actions: {
    async fetchUser({commit, dispatch}, {id}) {
      const idBis = 1;
      await axios.get(`http://localhost:4000/api/users/${idBis}`)
      commit('updateUsername', {id})
      await dispatch('fetchWorkingTimes')
      await dispatch('fetchClocks')
    },
    async fetchWorkingTimes({commit}) {
      const workingTimes = 'working_times'
      commit('updateWorkingTimes', {workingTimes})
    },
    async fetchClocks({commit}) {
      const clocks = 'clocks'
      commit('updateClocks', {clocks})
    },
    async updateUsername({commit}, {username}) {
      commit('updateUsername', {username})
    },
    async updateEmail({commit}, {email}) {
      commit('updateEmail', {email})
    }
  }
}

export default user