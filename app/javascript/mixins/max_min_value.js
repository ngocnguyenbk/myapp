export default {
  methods: {
    max_min_value: function(val, maxVal, minVal) {
      if (parseInt(val) < parseInt(minVal)) {
        return minVal;
      }
      return parseInt(val) > parseInt(maxVal) ? maxVal : val;
    },
  },
};
