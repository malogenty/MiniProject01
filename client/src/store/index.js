import { createStore } from 'vuex';
import {currentUser, users} from './modules'

export const store = createStore({
  modules: {
    currentUser,
    users,
  }
})