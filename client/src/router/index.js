import { createRouter, createWebHistory } from 'vue-router'
import HomeViewV2 from '@/views/HomeViewV2.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeViewV2
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('@/views/AuthView.vue')
  },
  {
    path: '/user/:id',
    name: 'user',
    component: () => import('@/views/UserViewV2.vue')
  },
  {
    path: '/team/:id',
    name: 'team',
    component: () => import('@/views/TeamPanel.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
