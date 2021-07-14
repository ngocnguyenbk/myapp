<template>
  <div :class="['form-group', colField]">
    <label
      :for="id"
      class="col-form-label"
    >{{ labelText }}</label>
    <input
      :id="id"
      class="form-control border-0"
      :value="value"
      readonly
    >
  </div>
</template>

<script>
export default {
  props: {
    id: {
      type: String,
      required: true,
    },
    labelText: {
      type: String,
      required: true,
    },
    value: {
      type: [Number, String],
      default: 0,
    },
    colField: {
      type: String,
      default: 'col-md-12',
    },
  },
};
</script>
