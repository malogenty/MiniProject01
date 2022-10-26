<template>
  <div class="home">
    <StoreTest :userId="1"/>
  </div>
</template>

<script>
// @ is an alias to /src
import StoreTest from '@/components/StoreTest.vue'

export default {
  name: 'HomeView',
  components: {
    StoreTest
  }
}
</script>
