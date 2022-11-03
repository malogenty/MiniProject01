<template>
  <div class="card">
    <slot/>
  </div>
</template>

<script>
export default {

}
</script>

<style scoped lang="scss">
@import "@/styles/colors.scss";
  .card {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 300px;
    background-color: $green;
    color: $black;
    font-size: 24px;
    font-weight: bold;
    border-radius: 16px;
    -webkit-box-shadow: 0px 0px 10px 3px rgba(0,0,0,0.5); 
    box-shadow: 0px 0px 10px 3px rgba(0,0,0,0.5);
    cursor: pointer;
  }
</style>