import axios from 'axios'
import moment from 'moment'

const workingTimes = {
  namespaced: true,
  state: () => ({
    workingTimes: []
  }),
  mutations: {
    addWorkingTime(state, workingTime) {
      state.workingTimes.push(workingTime)
    },
    addMultipleWorkingTimes(state, workingTimes) {
      workingTimes.forEach(wt => state.workingTime.push(wt))
    }
  },
  actions: {
    async fetchWorkingTimesFromTo({ rootGetters}, {from, to}) {
      try {
        const formatted_from = moment(from).format('YYYY-MM-DD hh:mm:ss')
        const formatted_to = moment(to).format('YYYY-MM-DD hh:mm:ss')
        const user = rootGetters['user/getUser']
        const {data} = await axios.get(`http://localhost:4000/api/workingtimes/${user.id}?start=${formatted_from}&end=${formatted_to}`)
        console.log(data)
        // commit('addMultipleWorkingTimes', data)
      } catch(e) {
        throw new Error(e)
      }
    },
    async fetchWorkingTime({commit, rootGetters}, {id}) {
      try {
        const user = rootGetters['user/getUser']
        const {data} = await axios.get(`http://localhost:4000/api/workingtimes/${user.id}/${id}`)
        commit('addWorkingTime', data)
      } catch(e) {
        throw new Error(e)
      }
    }
  },
  getters: {
    getWorkingTimes(state) {
      return state.workingTimes
    },
    getWorkingTimeById(state, {id}) {
      return this.state.filter(w => w.id ? w.id === id : {})
    }
  }
}

export default workingTimes