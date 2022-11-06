<template>
  <ContainerLayout>
    <div class="user-schedule">
      <span class="header">{{givenUser.username}}'s schedule</span>
    </div>
  </ContainerLayout>
</template>

<script>
import ContainerLayout from '../../Layout/ContainerLayout.vue'
export default {
    props: {
        givenUser: {}
    },
    components: { ContainerLayout }
}
</script>

<style lang="scss" scoped>
@import "@/styles/colors.scss";
  .container {
    background-color: $khaki;
  border-radius: 12px;

    .user-schedule {
      min-height: 500px;
      display: flex;
      flex-direction: column;
      .header {
      text-align: center;
      font-weight: bold;
      font-size: 1.2em;
    }
    }
  }
</style>