export default {
  methods: {
    max_value: function(val, maxVal) {
      return parseInt(val) > parseInt(maxVal) ? maxVal : val
    }
  }
}
