import { createStore } from 'vuex';
import {user, users, workingTimes} from './modules'

export const store = createStore({
  modules: {
    user,
    users,
    workingTimes
  }
})