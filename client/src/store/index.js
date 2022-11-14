import { createStore } from 'vuex';
import {currentUser, watchedUser, watchedTeam} from './modules'

export const store = createStore({
  modules: {
    currentUser,
    watchedUser,
    watchedTeam,
  }
})