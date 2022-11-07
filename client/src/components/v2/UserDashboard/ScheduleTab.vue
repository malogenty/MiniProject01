<template>
  <ContainerLayout>
    <div class="user-schedule">
      <span class="header">{{givenUser.username}}'s schedule</span>
      <div class="calendar-container">
        <VueCal hideWeekends hideViewSelector todayButton :dblclickToNavigate="false" 
  :editable-events="{ title: true, drag: false, resize: true, delete: true, create: true }"/>
      </div>
    </div>
  </ContainerLayout>
</template>

<script>
import ContainerLayout from '@/components/Layout/ContainerLayout.vue'

import VueCal from 'vue-cal'
import 'vue-cal/dist/vuecal.css'

export default {
    props: {
        givenUser: {}
    },
    components: { ContainerLayout, VueCal }
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
      .calendar-container {
        height: 600px;
      }
    }
  }
</style>