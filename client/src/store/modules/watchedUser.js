import router from '@/router'
import axios from 'axios'

const API_URL= process.env.AWS_DNS_NAME || 'http://localhost:4000/api'


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
    },
    async promoteUser({commit}, id) {
      try {
        const {data, status} = await axios.put(`${API_URL}/users/${id}/promote`)
        commit('setUser', data)
        return {status}
      } catch ({response}) {
        return {error: response.error, status: response.status}
      }
    },
    async deleteUser({rootGetters, dispatch, commit}, id) {
      const curr = rootGetters['currentUser/getUser']
      try {
        const {status} = await axios.delete(`${API_URL}/users/${id}`)
        if(curr.id === id) {
          dispatch('currentUser/logout', null, {root: true})
        } else {
          commit('resetState')
          router.back()
        }
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