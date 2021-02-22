<template>
  <div class="form-group row">
    <label :for="inputId" :class="['col-form-label', colLabel]" v-if="hasLabel">{{ labelText }}</label>
    <div :class="['align-self-center', colInput]">
      <div class="form-check form-check-inline" v-for="(val, key) in options" :key="key">
        <input type="radio" class="form-check-input" :id="inputId+'_'+key" :name="inputId" :checked="valueInput == key" :value="key" v-model="radioVal">
        <label class="form-check-label" :for="inputId+'_'+key">{{ val }}</label>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      radioVal: this.valueInput
    }
  },
  props: {
    inputId: {
      type: String,
      required: true
    },
    labelText: {
      type: String
    },
    options: {
      type: Object,
      required: true
    },
    valueInput: {
      type: String
    },
    colLabel: {
      type: String,
      default: "col-lg-2"
    },
    colInput: {
      type: String,
      default: "col-lg-10"
    },
    hasLabel: {
      type: Boolean,
      default: true
    }
  },
  watch: {
    radioVal: function(val) {
      this.$emit('input', val)
    },
    valueInput: function(val) {
      return this.radioVal = val
    }
  }
}
</script>
