<template>
  <div class="home">
    <!-- <img alt="Vue logo" src="../assets/logo.png">-->
    <HelloWorld msg="Welcome to Your Vue.js App"/>
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
