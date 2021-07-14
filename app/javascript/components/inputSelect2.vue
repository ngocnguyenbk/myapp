<template>
  <div class="form-group row">
    <label
      :for="inputId"
      :class="['col-form-label', colLabel]"
    >{{ labelText }}</label>
    <div :class="[colInput]">
      <select
        :id="inputId"
        :ref="typeSelect"
        class="form-control"
      >
        <option />
        <option
          v-for="(value, key) in options"
          :key="key"
          :value="key"
        >
          {{ value }}
        </option>
      </select>
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
    options: {
      type: Object,
      required: true,
    },
    selected: {
      type: [Number, String],
      default: 0,
    },
    typeSelect: {
      type: String,
      required: true,
    },
    eMsg: {
      type: String,
      default: ""
    },
    placeHolder: {
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
  },
  data: function() {
    return {
      valSelect: this.selected,
    };
  },
  mounted: function() {
    const vm = this;
    return $(`#${vm.inputId}`).select2({
      width: '100%',
      allowClear: true,
      placeholder: vm.placeHolder,
    }).on('select2:select select2:unselect', function() {
      vm.$emit('input', this.value);
    });
  },
  updated: function() {
    $(`#${this.inputId}`).val(this.selected || []).trigger('change');
  },
};
</script>
<style lang="scss" scoped>
.form {
  margin-bottom: 6px;
}
</style>
