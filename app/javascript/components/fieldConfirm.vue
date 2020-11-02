<template>
  <div class="form-group row">
    <label class="col-lg-2 col-form-label">{{lableText}}</label>
    <div class="col-lg-10">
      <span class="form-control string border-0">{{value}}</span>
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
