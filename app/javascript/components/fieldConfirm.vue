<template>
  <div class="form-group row">
    <label class="col-lg-2 col-form-label">{{lableText}}</label>
    <div class="col-lg-10">
      <input class="form-control border-0" :value="value" readonly>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    lableText: {
      type: String,
      required: true
    },
    value: {
      type: [Number, String]
    }
  }
}
</script>
