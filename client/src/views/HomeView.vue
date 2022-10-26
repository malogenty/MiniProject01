<template>
  <div class="home">
    <BaseFile/>
  </div>
</template>

<script>
// @ is an alias to /src
import BaseFile from '@/components/BaseFile.vue'

export default {
  name: 'HomeView',
  components: {
    BaseFile
  }
}
</script>
