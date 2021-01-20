export default {
  methods: {
    show_flash: function(isValid) {
      const self = this
      if (isValid) {
        this.flashMessage.success({
          time: 3000,
          message: self.flashMsg || self.$t('flash.success'),
        })
      } else {
        this.flashMessage.error({
          time: 3000,
          message: self.flashMsg || self.$t('flash.unsuccess')
        })
      }
    }
  }
}
