import axios from 'axios'
import moment from 'moment'

const API_URL='http://localhost:4000/api'

const getDefaultState = () => ({
  id: null,
  username: null,
  email: null,
  workingTimes: {},
  clocks: []
})

/**
 * This is the current user (the "parent" component). Once the user is fetched, the other data will be assigned to this user
 */
const currentUser = {
  namespaced: true,
  state: () => (getDefaultState()),

  // Mutations change the state, so it can trigger a re-rendering on some components that are linked.
  mutations: {
    // This is so we can start on fresh grounds when changing user.
    resetState (state) {
      Object.assign(state, getDefaultState())
    },
    // USER-SPECIFIC
    updateUser(state, {id, username, email}) {
      state.id = id
      state.username = username
      state.email = email
    },
    // WORKING TIME-SPECIFIC
    addMultipleWorkingTimes(state, workingTimes) {
      workingTimes.forEach(wt => state.workingTimes[wt.id] = wt)
    },
    updateWorkingTime(state, workingTime) {
      state.workingTimes[workingTime.id] = workingTime
    },
    deleteWorkingTime(state, workingTimeId) {
      state.workingTimes[workingTimeId] = null
    },
    // CLOCK-SPECIFIC
    addClock(state, clock) {
      state.clocks.push(clock)
    },
    addMultipleClocks(state, clocks) {
      state.clocks = []
      clocks.forEach(c => state.clocks.push(c))
    }

  },

  // Actions discuss with the back-end and trigger mutations
  actions: {
    // USER-SPECIFIC
    resetUser({commit}) {
      commit('resetState')
    },
    async fetchUser({commit}, {id}) {
      try {
        commit('resetState')
        const {data} = await axios.get(`${API_URL}/users/${id}`)
        commit('updateUser', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async updateUser({commit, state}, user) {
      try {
        const {data} = await axios.put(`${API_URL}/users/${state.id}`, {user})
        commit('updateUser', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async deleteUser({commit, state}) {
      try {
        await axios.delete(`${API_URL}/users/${state.id}`)
        commit('resetState')
      } catch(e) {
        throw new Error(e)
      }
    },
    // WORKING TIME SPECIFIC
    async fetchWorkingTimesStartEnd({ commit, state }, {start, end}) {
      try {
        const formatted_start = moment(start).startOf('day').format('YYYY-MM-DD%20HH:mm:ss')
        const formatted_end = moment(end).endOf('day').format('YYYY-MM-DD%20HH:mm:ss')
        console.log(formatted_start)
        console.log(formatted_end)
        const url = `${API_URL}/workingtimes/${state.id}?start=${formatted_start}&end=${formatted_end}`
        const {data} = await axios.get(url)
        commit('addMultipleWorkingTimes', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async fetchWorkingTime({commit, state}, {id}) {
      try {
        const {data} = await axios.get(`${API_URL}/workingtimes/${state.id}/${id}`)
        commit('updateWorkingTime', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async createWorkingTime({commit, state}, {start, end}) {
      try{
        const formatted_start = moment(start).format('YYYY-MM-DD%20hh:mm:ss')
        const formatted_end = moment(end).format('YYYY-MM-DD%20hh:mm:ss')
        const {data} = await axios.post(`${API_URL}/workingtimes/${state.id}`, {working_time: {start: formatted_start, end: formatted_end}})
        commit('updateWorkingTime', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async updateWorkingTime({commit}, workingTime) {
      try{
        let working_time = {}
        if (workingTime.start) working_time.start = moment(workingTime.start).format('YYYY-MM-DD%20hh:mm:ss')
        if (workingTime.end) working_time.end = moment(workingTime.end).format('YYYY-MM-DD%20hh:mm:ss')
        const {data} = await axios.put(`${API_URL}/workingtimes/${workingTime.id}`, {working_time})
        commit('updateWorkingTime', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async deleteWorkingTime({commit}, workingTimeId) {
      try {
        await axios.delete(`${API_URL}/workingtimes/${workingTimeId}`)
        commit('deleteWorkingTime', workingTimeId)
      } catch(e) {
        throw new Error(e)
      }
    },
    // CLOCKS SPECIFIC
    async fetchClocks({commit, state}) {
      try {
        const {data} = await axios.get(`${API_URL}/clocks/${state.id}`)
        commit('addMultipleClocks', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async createClock({commit, state}, {status}) {
      try {
        const {data} = await axios.post(`${API_URL}/clocks/${state.id}`, {status})
        commit('addClock', data)
      } catch(e) {
        throw new Error(e)
      }
    }
  },
  getters: {
    getUser({id, username, email, workingTimes, clocks}) {
      return ({
        id,
        username,
        email,
        workingTimes: Object.values(workingTimes),
        clocks
      })
    }
  }
}

export default currentUser