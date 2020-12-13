<template>
  <div class="form-group row">
    <label :for="inputId" :class="['col-form-label', colLable]" v-if="lableText">{{lableText}}</label>
    <div :class="[colInput]">
      <input type="number" class="form-control"  ref="input_number" :id="inputId" :max="max" v-model="inputVal">
      <span class="text-danger" v-if="eMsg">{{ eMsg }}</span>
    </div>
  </div>
</template>

<script>
import max_value_mixins from '../mixins/max_value'

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
      type: String
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
    },
    eMsg: {
      type: String
    },
    max: {
      type: String
    }
  },
  watch: {
    inputVal: function(val) {
      return this.$emit('input', val)
    },
    valueInput: function(val) {
      return this.inputVal = this.max_value(val, this.$refs.input_number.max)
    }
  },
  mixins: [max_value_mixins]
}
</script>
