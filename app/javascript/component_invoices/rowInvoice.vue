<template>
  <tr class="text-center">
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
      <i
        class="far fa-eye text-primary pointer"
        data-toggle="modal"
        data-target="#detailInvoice"
        @click="getDetailInvoice"
      />
    </td>
    <td class="text-center">
      <i
        class="fas fa-edit text-primary pointer mr-2"
        data-toggle="modal"
        data-target="#editInvoice"
        @click="setCurrentInvoice"
      />
      <i
        :class="['far fa-stop-circle text-danger ml-2', invoice.active ? 'pointer' : 'pointer_disable']"
        data-toggle="modal"
        data-target="#deleteInvoice"
        @click="setCurrentInvoice"
      />
    </td>
    <td>
      <a
        target="_blank"
        :href="show_invoice"
        class="btn btn-sm btn-primary mr-2"
      >
        <i class="fas fa-print" />
        <span>{{ $t('invoice.print_x') }}</span>
      </a>
      <a
        target="_blank"
        :href="download_invoice"
        class="btn btn-sm btn-info"
      >
        <i class="fa fa-download" />
        <span>{{ $t('invoice.download') }}</span>
      </a>
    </td>
  </tr>
</template>

<script>
import {createNamespacedHelpers} from 'vuex';
const {mapActions} = createNamespacedHelpers('invoice');

export default {
  props: {
    invoice: {
      type: Object,
      required: true,
    },
  },
  computed: {
    show_invoice: function() {
      return `/${locale}/invoices/${this.invoice.id}`;
    },
    download_invoice: function() {
      return `/${locale}/download/invoices/${this.invoice.id}`;
    },
  },
  methods: {
    ...mapActions({
      getInvoiceInfo: 'getDetailInvoice',
      setInvoice: 'setCurrentInvoice',
      clearErrorMessages: 'clearErrorMessages',
    }),
    getDetailInvoice: function() {
      this.getInvoiceInfo(this.invoice.id);
    },
    setCurrentInvoice: function() {
      this.setInvoice(this.invoice);
      this.clearErrorMessages();
    },
  },
};
</script>

<style lang="scss" scoped>
  .pointer {
    cursor: pointer;
  }
  tr > td {
    vertical-align: middle;
  }
  .pointer_disable {
    pointer-events: none;
    color: gray !important;
  }
</style>
