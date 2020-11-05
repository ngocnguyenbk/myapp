export default {
  methods: {
    show_flash: function(isValid) {
      if (isValid) {
        this.flashMessage.success({
          time: 3000,
          message: 'Success!'
        })
      } else {
        this.flashMessage.error({
          time: 3000,
          message: 'Unsuccess!'
        })
      }
    }
  }
}
