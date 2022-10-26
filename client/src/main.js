import { createApp } from 'vue'
import App from './App.vue'

const Test = { template: '<div>Test</div>' }

const routes = [
  { path: '/test', component: Test },
]

const router = VueRouter.createRouter({
  history: VueRouter.createWebHashHistory(),
  routes,
})

const app = createApp(App)
app.use(router)
app.mount('#app')
