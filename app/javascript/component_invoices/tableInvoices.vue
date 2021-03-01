<template>
  <table class="table table-multi-body table-bordered">
    <thead class="table-header">
      <tr class="table-head text-center">
        <th class="w-5 align-middle">{{ $t('invoice.invoice_id') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.room') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.month') }}</th>
        <th class="w-10 align-middle">{{ $t('invoice.price') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.electric') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.water') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.internet') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.parking_fee') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.service') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.reduce') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.total_income') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.details') }}</th>
        <th class="w-10 align-middle">{{ $t('invoice.export_print') }}</th>
      </tr>
    </thead>
    <RowInvoice :invoice="invoice" :odd="(index % 2) != 0" v-for="(invoice, index) in invoices" :key="index" />
    <DetailInvoice/>
  </table>
</template>

<script>
  import RowInvoice from './rowInvoice'
  import DetailInvoice from './detailInvoice'

  export default {
    components: {
      RowInvoice,
      DetailInvoice,
    },
    props: {
      invoices: {
        type: Array,
        required: true,
      },
    }
  }
</script>
