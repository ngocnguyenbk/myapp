<template>
  <div class="form-group row">
    <label :for="inputId" class="col-lg-2 col-form-label">{{lableText}}</label>
    <div class="col-lg-10">
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
    }
  },
  mounted: function() {
    let vm = this
    return $(`#${vm.inputId}`).select2({
      width: '100%',
      allowClear: true,
      placeholder: "Select room",
    }).on('select2:select select2:unselect', function() {
      vm.$emit('input', this.value)
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
