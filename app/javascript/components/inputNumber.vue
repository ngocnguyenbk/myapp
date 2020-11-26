<template>
  <div class="form-group row">
    <label :for="inputId" :class="['col-form-label', colLable]">{{lableText}}</label>
    <div :class="[colInput]">
      <input type="number" class="form-control" :id="inputId" v-model="inputVal">
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
