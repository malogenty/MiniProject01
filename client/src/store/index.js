import { createStore } from 'vuex';
import {currentUser, watchedUser, watchedTeam, signUpUser} from './modules'

export const store = createStore({
  modules: {
    currentUser,
    watchedUser,
    watchedTeam,
    signUpUser
  }
})