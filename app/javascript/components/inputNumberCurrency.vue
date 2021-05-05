<template>
  <div class="form-group row">
    <label :for="inputId" :class="['col-form-label', colLabel]">{{ labelText }}</label>
    <div :class="[colInput]">
      <input type="text" class="form-control" :id="inputId" v-model="inputVal" autocomplete="off">
      <span class="text-danger" v-if="eMsg">{{ eMsg }}</span>
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
    labelText: {
      type: String,
      required: true
    },
    valueInput: {
      type: [Number, String]
    },
    eMsg: {
      type: String
    },
    colLabel: {
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
      return this.inputVal = numeral(val).format('0,0')
    }
  }
}
</script>
