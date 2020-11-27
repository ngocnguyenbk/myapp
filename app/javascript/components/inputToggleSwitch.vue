<template>
  <div class="form-group row">
    <div class="col-lg-2">
      <label class="switch">
        <input type="checkbox" v-model="checked">
        <span class="slider round"></span>
      </label>
    </div>
    <label :for="inputId" class="col-lg-2 col-form-label">{{lableText}}</label>
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
      return this.$emit('checked', val)
    },
    value: function(val) {
      return this.checked = val
    }
  }
}
</script>
