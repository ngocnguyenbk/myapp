<template>
  <div class="form-group row">
    <label :for="inputId" :class="['col-form-label', colLable]">{{lableText}}</label>
    <div :class="[colInput]">
      <select class="form-control" :id="inputId" :ref="typeSelect">
        <option></option>
        <option v-for="(value, key) in options" :value="key" :key="key">{{value}}</option>
      </select>
      <span class="text-danger" v-if="eMsg">{{ eMsg }}</span>
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      valSelect: this.selected
    }
  },
  props: {
    inputId: {
      type: String,
      required: true
    },
    lableText: {
      type: String,
      required: true
    },
    options: {
      type: Object,
      required: true
    },
    selected: {
      type: [Number, String]
    },
    typeSelect: {
      type: String,
      required: true
    },
    eMsg: {
      type: String
    },
    placeHolder: {
      type: String
    },
    colLable: {
      type: String,
      default: "col-lg-2"
    },
    colInput: {
      type: String,
      default: "col-lg-10"
    }
  },
  mounted: function() {
    let vm = this
    return $(`#${vm.inputId}`).select2({
      width: '100%',
      allowClear: true,
      placeholder: vm.placeHolder,
    }).on('select2:select select2:unselect', function() {
      vm.$emit('input', vm.value)
    })
  },
  updated: function() {
    $(`#${this.inputId}`).val(this.selected || []).trigger('change')
  },
}
</script>
<style lang="scss" scoped>
.form {
  margin-bottom: 6px;
}
</style>
