<template>
  <div class="form-group row">
    <label :for="inputId" :class="['col-form-label', colLabel]">{{ labelText }}</label>
    <div :class="[colInput]">
      <Datepicker
        v-model="inputVal"
        name="month_export-invoice"
        :id="inputId"
        :language="locale[language]"
        :format="dateFormat"
        :minimum-view="minimumView" 
        :maximum-view="maximumView"
      >
      </Datepicker>
      <span class="text-danger" v-if="eMsg">{{ eMsg }}</span>
    </div>
  </div>
</template>

<script>
import Datepicker from 'vuejs-datepicker'
import { en, vi } from 'vuejs-datepicker/dist/locale'

export default {
  data: function() {
    return {
      inputVal: this.valueInput,
      locale: {
        "en": en,
        "vi": vi,
      }
    }
  },
  components: {
    Datepicker,
  },
  props: {
    inputId: {
      type: String,
      required: true
    },
    labelText: {
      type: String,
      required: true
    },
    valueInput: {
      type: [Number, String]
    },
    eMsg: {
      type: String
    },
    colLabel: {
      type: String,
      default: "col-lg-2"
    },
    colInput: {
      type: String,
      default: "col-lg-10"
    },
    language: {
      type: String,
      default: "vi",
    },
    dateFormat: {
      type: String,
      default: "dd/MM/yyyy",
    },
    minimumView: {
      type: String,
    },
    maximumView: {
      type: String,
    }
  },
  watch: {
    inputVal: function(val) {
      return this.$emit('input', val)
    },
    valueInput: function(val) {
      return this.inputVal = val
    }
  }
}
</script>
