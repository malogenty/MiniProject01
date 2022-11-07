<template>
  <Datepicker lang="en" range v-model="range" position="bottom" :disabled-end-date="disabledEndDate"/>
</template>

<script>
  import moment from 'moment';
  import 'vue-datepicker-ui/lib/vuedatepickerui.css';
  import VueDatepickerUi from 'vue-datepicker-ui';

  export default {
    components: {
      Datepicker: VueDatepickerUi
    },
    props: {},
    data() {
      return {
        range: [
          new Date(moment().subtract(1, "month")), new Date()
        ],
        disabledEndDate: {
          from: new Date(), 
          to: null
        }
      }
    },
    watch: {
      range(n) {
        this.$emit('dateChange', n)
      }
    }
  }
</script>