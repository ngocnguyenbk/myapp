<template>
  <div class="form-group row">
    <label
      :for="inputId"
      :class="['col-form-label', colLabel]"
    >{{ labelText }}</label>
    <div :class="[colInput]">
      <input
        :id="inputId"
        v-model="inputVal"
        type="text"
        class="form-control"
        autocomplete="off"
      >
      <span
        v-if="eMsg"
        class="text-danger"
      >{{ eMsg }}</span>
    </div>
  </div>
</template>

<script>
export default {
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
      type: [Number, String],
      default: 0,
    },
    eMsg: {
      type: String,
      default: ""
    },
    colLabel: {
      type: String,
      default: 'col-lg-2',
    },
    colInput: {
      type: String,
      default: 'col-lg-10',
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
      return this.inputVal = numeral(val).format('0,0');
    },
  },
};
</script>
