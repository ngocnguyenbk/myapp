export default {
  methods: {
    handle_errors: function(val) {
      let errors = {}
      for (const [key, child] of Object.entries(val)) {
        errors[key] = {}
        for (const [index, messages] of Object.entries(child)) {
          errors[key][index] = messages[0]
        }
      }
      return errors
    }
  }
}
