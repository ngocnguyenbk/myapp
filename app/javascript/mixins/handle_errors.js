export default {
  methods: {
    handle_errors: function(val) {
      const errors = {};
      for (const [key, child] of Object.entries(val)) {
        errors[key] = {};
        for (const [index, messages] of Object.entries(child)) {
          errors[key][index] = messages[0];
        }
      }
      return errors;
    },
    handle_single_error: function(val) {
      const errors = {};
      for (const [key, message] of Object.entries(val)) {
        errors[key] = message[0];
      }
      return errors;
    },
  },
};
