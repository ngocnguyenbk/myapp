<template>
  <form id="new-invoices" @submit.prevent="checkForm">
    <button class="btn btn-primary float-right mb-2" v-if="isValid">{{ $t('invoice.submit_form') }}</button>
    <button class="btn btn-primary float-right mb-2" v-else>{{ $t('invoice.check_form') }}</button>
    <table class="table table-multi-body table-bordered">
      <thead class="table-header">
        <tr class="table-head text-center">
          <td rowspan="2">{{ $t('invoice.room') }}</td>
          <td rowspan="2">{{ $t('invoice.deposited') }}</td>
          <td rowspan="2" class="w-100px">{{ $t('invoice.price') }}</td>
          <td colspan="4">{{ $t('invoice.electric') }}</td>
          <td colspan="4">{{ $t('invoice.water') }}</td>
          <td rowspan="2">{{ $t('invoice.internet') }}</td>
          <td rowspan="2">{{ $t('invoice.parking_fee') }}</td>
          <td rowspan="2">{{ $t('invoice.num') }}</td>
          <td rowspan="2">{{ $t('invoice.service') }}</td>
          <td rowspan="2" class="w-180px">{{ $t('invoice.total') }}</td>
          <td rowspan="2">{{ $t('invoice.reduce') }}</td>
          <td rowspan="2" class="w-160px">{{ $t('invoice.holder') }}</td>
          <td rowspan="2" class="w-180px">{{ $t('invoice.note') }}</td>
        </tr>
        <tr>
          <td class="w-70px">{{ $t('invoice.begin_number') }}</td>
          <td class="w-70px">{{ $t('invoice.end_number') }}</td>
          <td>{{ $t('invoice.use') }}</td>
          <td class="w-75px">{{ $t('invoice.into_money') }}</td>
          <td class="w-70px">{{ $t('invoice.begin_number') }}</td>
          <td class="w-70px">{{ $t('invoice.end_number') }}</td>
          <td>{{ $t('invoice.use') }}</td>
          <td class="w-75px">{{ $t('invoice.into_money') }}</td>
        </tr>
      </thead>
      <RowInvoiceForm
        :item="item"
        :room_number="room_number"
        v-for="(item, room_number) in invoicesForm" :key="room_number"
      />
    </table>
    <button class="btn btn-primary float-right mb-2" v-if="isValid">{{ $t('invoice.submit_form') }}</button>
    <button class="btn btn-primary float-right mb-2" v-else>{{ $t('invoice.check_form') }}</button>
  </form>
</template>

<script>
import { mapState } from 'vuex'
import show_flash_mixins from '../../mixins/show_flash'

import RowInvoiceForm from './rowInvoiceForm'

export default {
  components: {
    RowInvoiceForm
  },
  data: function() {
    return {
      flashMsg: '',
      isValid: false
    }
  },
  computed: {
    ...mapState({
      invoicesForm: state => state.invoice.invoicesForm,
      inputForm: state => state.invoice.inputForm
    })
  },
  created: function() {
    this.$store.dispatch('invoice/getInvoiceForm')
  },
  methods: {
    checkForm: function() {
      if (this.isValid) {
        this.submitForm()
      } else {
        this.validForm()
      }
    },
    validForm: function() {
      let self = this
      $.each(this.inputForm, function(key, item) {
        let validEle = item.electric.end_number > item.electric.begin_number
        let validWat = item.water.end_number > item.water.begin_number
        self.isValid = item.electric.total > 0 && item.water.total > 0 &&
                      item.invoice.total > 0 && validEle && validWat
        if (!self.isValid) {
          self.flashMsg = self.$t('invoice.error_msg', { room: key })
          return false
        }
      })
      if (this.isValid){
        this.flashMsg = this.$t('invoice.success_msg')
        this.show_flash(true)
      } else {
        this.show_flash(false)
      }
    },
    submitForm: function() {
      if (!this.isValid) return

      this.$store.dispatch('invoice/createInvoices', { params: this.inputForm })
    }
  },
  mixins: [show_flash_mixins]
}
</script>
