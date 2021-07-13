<template>
  <div class="form-group row">
    <label
      v-if="labelText"
      :for="inputId"
      :class="['col-form-label', colLabel]"
    >{{ labelText }}</label>
    <div :class="[colInput]">
      <input
        :id="inputId"
        ref="input_number"
        v-model="inputVal"
        type="number"
        class="form-control"
        :max="max"
        :min="min"
      >
      <span
        v-if="eMsg"
        class="text-danger"
      >{{ eMsg }}</span>
    </div>
  </div>
</template>

<script>
import max_min_value_mixins from '../mixins/max_min_value';

export default {
  mixins: [max_min_value_mixins],
  props: {
    inputId: {
      type: String,
      required: true,
    },
    labelText: {
      type: String,
      default: '',
    },
    valueInput: {
      type: [Number, String],
      default: 0,
    },
    colLabel: {
      type: String,
      default: 'col-lg-2',
    },
    colInput: {
      type: String,
      default: 'col-lg-10',
    },
    eMsg: {
      type: String,
      default: "",
    },
    max: {
      type: String,
      default: '',
    },
    min: {
      type: String,
      default: '',
    },
  },
  data: function() {
    return {
      inputVal: this.valueInput,
    };
  },
  watch: {
    inputVal: function(val) {
      return this.$emit('input', val);
    },
    valueInput: function(val) {
      return this.inputVal = this.max_min_value(val, this.$refs.input_number.max, this.$refs.input_number.min);
    },
  },
};
</script>
