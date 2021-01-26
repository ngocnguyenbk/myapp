<template>
  <div class="form-group row">
    <label :class="['col-form-label', colLable]">{{labelText}}</label>
    <div :class="[colInput]">
      <input class="form-control border-0" :value="value" readonly>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    labelText: {
      type: String,
      required: true
    },
    value: {
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
  }
}
</script>
