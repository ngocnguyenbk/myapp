<template>
  <div class="form-group row">
    <label
      :for="inputId"
      :class="['col-form-label', colLabel]"
    >{{ labelText }}</label>
    <div :class="[colInput]">
      <Datepicker
        :id="inputId"
        v-model="inputVal"
        name="month_export-invoice"
        input-class="form-control"
        :language="locale[language]"
        :format="dateFormat"
        :minimum-view="minimumView"
        :maximum-view="maximumView"
      />
      <span
        v-if="eMsg"
        class="text-danger"
      >{{ eMsg }}</span>
    </div>
  </div>
</template>

<script>
import Datepicker from 'vuejs-datepicker';
import {en, vi} from 'vuejs-datepicker/dist/locale';

export default {
  components: {
    Datepicker,
  },
  props: {
    inputId: {
      type: String,
      required: true,
    },
    labelText: {
      type: String,
      required: true,
    },
    valueInput: {
      type: [String, Date],
      default: new Date(),
    },
    eMsg: {
      type: String,
      default: '',
    },
    colLabel: {
      type: String,
      default: 'col-lg-2',
    },
    colInput: {
      type: String,
      default: 'col-lg-10',
    },
    language: {
      type: String,
      default: 'vi',
    },
    dateFormat: {
      type: String,
      default: 'dd/MM/yyyy',
    },
    minimumView: {
      type: String,
      default: 'day', 
    },
    maximumView: {
      type: String,
      default: 'year',
    },
  },
  data: function() {
    return {
      inputVal: this.valueInput,
      locale: {
        'en': en,
        'vi': vi,
      },
    };
  },
  watch: {
    inputVal: function(val) {
      return this.$emit('input', val);
    },
    valueInput: function(val) {
      return this.inputVal = val;
    },
  },
};
</script>
