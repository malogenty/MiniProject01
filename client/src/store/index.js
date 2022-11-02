import { createStore } from 'vuex';
import {currentUser, watchedUser, teams} from './modules'

export const store = createStore({
  modules: {
    currentUser,
    watchedUser,
    teams
  }
})