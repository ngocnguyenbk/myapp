<template>
  <div class="form-group row">
    <label :for="inputId" class="col-lg-2 col-form-label">{{lableText}}</label>
    <div class="col-lg-10">
      <select class="form-control" :id="inputId" :ref="typeSelect">
        <option v-for="(value, key) in options" :value="key">{{value}}</option>
      </select>
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
    }
  },
  mounted: function() {
    var vm = this
    return $(`#${this.inputId}`).select2({
      width: '100%',
      allowClear: true,
      placeholder: "Select an user",
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
