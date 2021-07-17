<template>
  <div class="table-responsive">
    <table class="table table-bordered table-striped">
      <thead class="table-header">
        <tr class="table-head text-center">
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.invoice_id') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.room') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.month') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.price') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.electric') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.water') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.internet') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.unit_price_parking_fee') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.service') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.reduce') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.total_income') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.details') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.edit_or_delete') }}
          </th>
          <th
            scope="col"
            class="align-middle"
          >
            {{ $t('invoice.export_print') }}
          </th>
        </tr>
      </thead>
      <tbody>
        <RowInvoice
          v-for="(invoice, index) in invoices"
          :key="index"
          :invoice="invoice"
        />
      </tbody>
      <EditInvoice ref="modal_edit" />
      <DetailInvoice />
      <DeleteInvoice />
    </table>
  </div>
</template>

<script>
import RowInvoice from './rowInvoice';
import DetailInvoice from './detailInvoice';
import EditInvoice from './editInvoice';
import DeleteInvoice from './deleteInvoice';

export default {
  components: {
    RowInvoice,
    DetailInvoice,
    EditInvoice,
    DeleteInvoice,
  },
  props: {
    invoices: {
      type: Array,
      required: true,
    },
  },
};
</script>
