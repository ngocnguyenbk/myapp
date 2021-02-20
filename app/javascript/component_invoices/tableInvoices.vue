<template>
  <table class="table table-multi-body table-bordered">
    <thead class="table-header">
      <tr class="table-head text-center">
        <td class="w-5 align-middle">{{ $t('invoice.invoice_id') }}</td>
        <td class="w-5 align-middle">{{ $t('invoice.room') }}</td>
        <td class="w-5 align-middle">{{ $t('invoice.month') }}</td>
        <td class="w-10 align-middle">{{ $t('invoice.price') }}</td>
        <td class="w-10 align-middle">{{ $t('invoice.electric') }}</td>
        <td class="w-10 align-middle">{{ $t('invoice.water') }}</td>
        <td class="w-10 align-middle">{{ $t('invoice.internet') }}</td>
        <td class="w-10 align-middle">{{ $t('invoice.parking_fee') }}</td>
        <td class="w-5 align-middle">{{ $t('invoice.service') }}</td>
        <td class="w-5 align-middle">{{ $t('invoice.reduce') }}</td>
        <td class="w-10 align-middle">{{ $t('invoice.total_income') }}</td>
        <td class="w-10 align-middle">{{ $t('invoice.export_print') }}</td>
      </tr>
    </thead>
    <RowInvoice :invoice="invoice" :odd="(index % 2) != 0" v-for="(invoice, index) in invoices" :key="index" />
  </table>
</template>

<script>
  import RowInvoice from './rowInvoice.vue'

  export default {
    components: {
      RowInvoice,
    },
    props: {
      invoices: {
        type: Array,
        required: true,
      },
    }
  }
</script>
