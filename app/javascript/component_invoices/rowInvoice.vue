<template>
  <tbody :class="[background_row_invoice, 'text-center']">
    <tr>
      <td>{{ invoice.id }}</td>
      <td>{{ invoice.room_number }}</td>
      <td>{{ invoice.month }}</td>
      <td>{{ invoice.room_price | formatNumber }}</td>
      <td>{{ invoice.total_electric | formatNumber }}</td>
      <td>{{ invoice.total_water | formatNumber }}</td>
      <td>{{ invoice.total_internet | formatNumber }}</td>
      <td>{{ invoice.total_parking_fee | formatNumber }}</td>
      <td>{{ invoice.total_service | formatNumber }}</td>
      <td>{{ invoice.reduce | formatNumber }}</td>
      <td>{{ invoice.total | formatNumber }}</td>
      <td class="text-center">
        <i class="far fa-eye text-primary pointer"
           data-toggle="modal"
           data-target="#detailInvoice"
           @click="getDetailInvoice"
        />
      </td>
      <td>
        <a target="_blank" :href="show_invoice">
          <i class="fas fa-print"></i>
        </a>
      </td>
    </tr>
  </tbody>
</template>

<script>
import { createNamespacedHelpers } from 'vuex'
const { mapState, mapActions } = createNamespacedHelpers('invoice')

export default {
  props: {
    invoice: {
      type: Object,
      required: true,
    },
    odd: {
      type: Boolean,
      required: true,
    }
  },
  computed: {
    background_row_invoice: function() {
      return this.odd ? 'odd-bg' : 'even-bg'
    },
    show_invoice: function() {
      return `/${locale}/invoices/${this.invoice.id}`
    }
  },
  methods: {
    ...mapActions({ getInvoiceInfo: 'getDetailInvoice' }),
    getDetailInvoice: function() {
      this.getInvoiceInfo(this.invoice.id)
    }
  }
}
</script>

<style lang="scss" scoped>
  .pointer {
    cursor: pointer;
  }
</style>
