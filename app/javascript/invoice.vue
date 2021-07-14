<template>
  <div id="app">
    <div class="d-flex">
      <FlashMessage :position="'right top'" />
      <div :class="[{ 'mb-2': !showPaginate }]">
        <a
          class="btn btn-sm btn-primary"
          :href="batchCreateInvoicePath"
        >{{ $t('invoice.batch_create') }}</a>
        <a
          class="btn btn-sm btn-primary ml-2"
          :href="newInvoicePath"
        >{{ $t('invoice.add_invoice') }}</a>
      </div>
      <div class="ml-auto">
        <Paginator
          :current-page="currentPage"
          :show-paginate="showPaginate"
          :total-pages="totalPages"
          :load-objects="loadInvoices"
        />
      </div>
      <br>
    </div>
    <TableInvoice
      :invoices="invoices"
    />
  </div>
</template>

<script>
import {mapState} from 'vuex';
import TableInvoice from './component_invoices/tableInvoices.vue';
import Paginator from './components/paginator.vue';

export default {
  components: {
    TableInvoice,
    Paginator,
  },
  data: function() {
    return {
      batchCreateInvoicePath: `/${locale}/batch_create/invoices/new`,
      newInvoicePath: `/${locale}/invoices/new`,
    };
  },
  computed: {
    ...mapState({
      params: (state) => state.invoice.params,
      totalPages: (state) => state.invoice.totalPages,
      showPaginate: (state) => state.invoice.showPaginate,
      invoices: (state) => state.invoice.invoices,
    }),
    currentPage: {
      get() {
        return this.$store.state.invoice.currentPage;
      },
      set(val) {
        this.$store.commit('invoice/setCurrentPage', val);
      },
    },
  },
  created: function() {
    this.$store.dispatch('invoice/getInvoices');
  },
  methods: {
    loadInvoices: function(current_page) {
      this.$store.dispatch('invoice/submitFormSearch', {params: this.params, page: current_page});
    },
  },
};
</script>
