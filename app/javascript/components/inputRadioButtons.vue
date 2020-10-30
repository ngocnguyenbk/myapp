<template>
  <div class="form-group row">
    <label :for="inputId" class="col-lg-2 col-form-label">{{lableText}}</label>
    <div class="col-lg-10 align-self-center">
      <div class="form-check form-check-inline" v-for="(val, key) in options">
        <input type="radio" class="form-check-input" :id="inputId+'_'+key" :name="inputId" :checked="valueInput == key" :value="key" v-model="radioVal">
        <label class="form-check-label" :for="inputId+'_'+key">{{val}}</label>
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
    lableText: {
      type: String,
      required: true
    },
    options: {
      type: Object,
      required: true
    },
    valueInput: {
      type: String
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
