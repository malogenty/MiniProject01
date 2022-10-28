<template>
  <div class="home">
    <UserGrid/>
  </div>
</template>

<script>
// @ is an alias to /src
import UserGrid from '@/components/UserGrid.vue'

export default {
  name: 'HomeView',
  components: {
    UserGrid
  }
}
</script>
