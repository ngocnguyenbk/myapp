<template>
  <div class="form-group row">
    <label :for="inputId" class="col-lg-2 col-form-label">{{lableText}}</label>
    <div class="col-lg-10">
      <label class="switch">
        <input type="checkbox" v-model="checked">
        <span class="slider round"></span>
      </label>
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      checked: this.value
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
    value: {
      type: Boolean
    }
  },
  watch: {
    checked: function(val) {
      return this.$emit('input', val)
    },
    value: function(val) {
      return this.checked = val
    }
  }
}
</script>
