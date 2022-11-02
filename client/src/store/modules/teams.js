// import axios from 'axios'


// const API_URL='http://localhost:4000/api'

const getDefaultState = () => ({
  id: null,
  username: null,
  email: null,
  workingTimes: {},
  clocks: {}
})

const teams = {
  namespaced: true,
  state: () => (getDefaultState()),
  mutations: {

  },
  actions: {},
  getters: {}
}

export default teams