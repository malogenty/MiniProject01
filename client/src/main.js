import { createApp } from 'vue'
import { store } from './store'
import App from './App.vue'
import router from './router'
import VueCookies from 'vue-cookies'

createApp(App).use(VueCookies).use(store).use(router).mount('#app')
