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
      box-shadow: 2px 2px 0px 0px darken(#f0f0f0, 20%);
      -webkit-box-shadow: 2px 2px 0px 0px darken(#f0f0f0, 20%);
    }
  }
</style>