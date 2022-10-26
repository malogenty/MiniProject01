import { createStore } from 'vuex';
import {user, users} from './modules'

export const store = createStore({
  modules: {
    user,
    users
  }
})