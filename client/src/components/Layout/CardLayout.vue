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
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 10vh;
    background-color: white;
    color: $black;
    font-size: 24px;
    font-weight: bold;
    border-radius: 16px;
    cursor: pointer;
    transition: all 250ms ease;
    border: solid 2px $green;

    &:hover {
      box-shadow: 0px 0px 7px 2px rgba(0,0,0,0.33);
      -webkit-box-shadow: 0px 0px 7px 2px rgba(0,0,0,0.33);
    }
  }
</style>