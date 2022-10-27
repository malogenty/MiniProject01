<template>
  <div class="home">
    <StoreTest :userId="1"/>
    <UserGrid/>
  </div>
</template>

<script>
// @ is an alias to /src
import StoreTest from '@/components/StoreTest.vue'
import UserGrid from '@/components/UserGrid.vue'

export default {
  name: 'HomeView',
  components: {
    StoreTest,
    UserGrid
  }
}
</script>
