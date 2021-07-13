<template>
  <div class="form-group row">
    <div class="col-lg-2">
      <label class="switch">
        <input
          v-model="checked"
          type="checkbox"
        >
        <span class="slider round" />
      </label>
    </div>
    <label
      :for="inputId"
      class="col-lg-2 col-form-label"
    >{{ labelText }}</label>
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
    value: {
      type: Boolean,
    },
  },
  data: function() {
    return {
      checked: this.value,
    };
  },
  watch: {
    checked: function(val) {
      return this.$emit('checked', val);
    },
    value: function(val) {
      return this.checked = val;
    },
  },
};
</script>
