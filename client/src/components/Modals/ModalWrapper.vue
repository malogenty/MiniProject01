<template>
  <div class="modal-wrapper">
    <div class="modal">
      <slot/>
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
.modal-wrapper {
  height: 100vh;
  width: 100%;
  position: absolute;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(0, 0, 0, 0.5);
  .modal {
    min-height: 15vw;
    width: 40vw;
    background: white;;
    border-radius: 5px;
    padding: 1vw;
    display: flex;
    flex-direction: column;
   
  }
}

</style>