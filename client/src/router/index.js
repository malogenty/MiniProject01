import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/clock/:username',
    name: 'clock',
    component: () => import('../views/ClockView.vue')
  },
  {
    path: '/user/:id',
    props: {
      id: Number
    },
    name: 'user',
    component: () => import('@/views/UserView.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
