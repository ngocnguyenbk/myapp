<template>
  <div class="form-group row">
    <label :for="inputId" class="col-lg-2 col-form-label">{{lableText}}</label>
    <div class="col-lg-10">
      <input type="text" class="form-control" :id="inputId" v-model="inputVal">
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      inputVal: this.valueInput
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
    valueInput: {
      type: [Number, String]
    }
  },
  watch: {
    inputVal: function(val) {
      return this.$emit('input', val)
    },
    valueInput: function(val) {
      return this.inputVal = val
    }
  }
}
</script>
