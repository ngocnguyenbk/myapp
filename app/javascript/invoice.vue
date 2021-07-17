<template>
  <div id="app">
    <SearchForm />
    <div :class="['d-flex', {'mb-2': !showPaginate}]">
      <FlashMessage :position="'right top'" />
      <div>
        <div
          class="btn-group"
          role="group"
        >
          <a
            class="btn btn-primary"
            :href="batchCreateInvoicePath"
          >{{ $t('invoice.batch_create') }}</a>
          <button
            type="button"
            class="btn btn-secondary mr-0 ml-0 pr-0 pl-0"
            disabled
          />
          <a
            class="btn btn-primary"
            :href="newInvoicePath"
          >{{ $t('invoice.add_invoice') }}</a>
        </div>
      </div>
      <div class="ml-auto">
        <Paginator
          :current-page="currentPage"
          :show-paginate="showPaginate"
          :total-pages="totalPages"
          :total-count="totalCount"
          :load-objects="loadInvoices"
        />
      </div>
      <br>
    </div>
    <TableInvoice
      :invoices="invoices"
    />
    <div class="d-flex flex-row-reverse">
      <Paginator
        :current-page="currentPage"
        :show-paginate="showPaginate"
        :total-pages="totalPages"
        :total-count="totalCount"
        :load-objects="loadInvoices"
      />
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import TableInvoice from './component_invoices/tableInvoices.vue';
import Paginator from './components/paginator.vue';
import SearchForm from './component_invoices/searchForm';

export default {
  components: {
    TableInvoice,
    Paginator,
    SearchForm,
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
      totalCount: (state) => state.invoice.totalCount,
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
