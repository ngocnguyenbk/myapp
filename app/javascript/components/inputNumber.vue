<template>
  <div class="form-group row">
    <label :for="inputId" :class="['col-form-label', colLabel]" v-if="labelText">{{ labelText }}</label>
    <div :class="[colInput]">
      <input type="number" class="form-control"  ref="input_number" :id="inputId" :max="max" :min="min" v-model="inputVal">
      <span class="text-danger" v-if="eMsg">{{ eMsg }}</span>
    </div>
  </div>
</template>

<script>
import max_min_value_mixins from '../mixins/max_min_value'

export default {
  data: function() {
    return {
      inputVal: this.valueInput
    }
  },
  props: {
    inputId: {
      type: String,
      required: true
    },
    labelText: {
      type: String
    },
    valueInput: {
      type: [Number, String]
    },
    colLabel: {
      type: String,
      default: "col-lg-2"
    },
    colInput: {
      type: String,
      default: "col-lg-10"
    },
    eMsg: {
      type: String
    },
    max: {
      type: String
    },
    min: {
      type: String
    }
  },
  watch: {
    inputVal: function(val) {
      return this.$emit('input', val)
    },
    valueInput: function(val) {
      return this.inputVal = this.max_min_value(val, this.$refs.input_number.max, this.$refs.input_number.min)
    }
  },
  mixins: [max_min_value_mixins]
}
</script>
