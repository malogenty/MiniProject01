import { createStore } from 'vuex';
import {currentUser, watchedUser, watchedTeam} from './modules'

const API_URL= process.env.AWS_DNS_NAME || 'http://localhost:4000/api'

export const store = createStore({
  modules: {
    currentUser,
    watchedUser,
    watchedTeam
  }
})