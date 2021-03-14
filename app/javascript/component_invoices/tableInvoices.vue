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
        <th class="w-5 align-middle">{{ $t('invoice.unit_price_parking_fee') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.service') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.reduce') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.total_income') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.details') }}</th>
        <th class="w-5 align-middle">{{ $t('invoice.edit_or_delete') }}</th>
        <th class="w-10 align-middle">{{ $t('invoice.export_print') }}</th>
      </tr>
    </thead>
    <RowInvoice :invoice="invoice" :odd="(index % 2) != 0" v-for="(invoice, index) in invoices" :key="index" />
    <EditInvoice ref="modal_edit"/>
    <DetailInvoice/>
  </table>
</template>

<script>
  import RowInvoice from './rowInvoice'
  import DetailInvoice from './detailInvoice'
  import EditInvoice from './editInvoice'

  export default {
    components: {
      RowInvoice,
      DetailInvoice,
      EditInvoice,
    },
    props: {
      invoices: {
        type: Array,
        required: true,
      },
    }
  }
</script>
