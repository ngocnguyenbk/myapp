<template>
  <div class="form-group row">
    <label
      v-if="hasLabel"
      :for="inputId"
      :class="['col-form-label', colLabel]"
    >{{ labelText }}</label>
    <div :class="['align-self-center', colInput]">
      <div
        v-for="(val, key) in options"
        :key="key"
        class="form-check form-check-inline"
      >
        <input
          :id="inputId+'_'+key"
          v-model="radioVal"
          type="radio"
          class="form-check-input"
          :name="inputId"
          :checked="valueInput == key"
          :value="key"
        >
        <label
          class="form-check-label"
          :for="inputId+'_'+key"
        >{{ val }}</label>
      </div>
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
      default: "Default labelText",
    },
    options: {
      type: Object,
      required: true,
    },
    valueInput: {
      type: String,
      default: "default valueInput",
    },
    colLabel: {
      type: String,
      default: 'col-lg-2',
    },
    colInput: {
      type: String,
      default: 'col-lg-10',
    },
    hasLabel: {
      type: Boolean,
      default: true,
    },
  },
  data: function() {
    return {
      radioVal: this.valueInput,
    };
  },
  watch: {
    radioVal: function(val) {
      this.$emit('input', val);
    },
    valueInput: function(val) {
      return this.radioVal = val;
    },
  },
};
</script>
