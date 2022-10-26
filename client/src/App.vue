<script>
import ClockComponent from './components/ClockComponent.vue'
import NotFound from './components/NotFound.vue'
import BaseFile from './components/BaseFile.vue'

const routes = {
  '/': BaseFile,
  '/about': ClockComponent
}

export default {
  data() {
    return {
      currentPath: window.location.hash
    }
  },
  computed: {
    currentView() {
      return routes[this.currentPath.slice(1) || '/'] || NotFound
    }
  },
  mounted() {
    window.addEventListener('hashchange', () => {
      this.currentPath = window.location.hash
		})
  }
}
</script>

<template>
  <a href="#/">Home</a> |
  <a href="#/about">About</a> |
  <a href="#/non-existent-path">Broken Link</a>
  <component :is="currentView" />
</template>