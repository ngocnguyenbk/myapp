<template>
  <div id="app">
    <div class="d-flex mb-2">
      <FlashMessage :position="'right top'"></FlashMessage>
      <div>
        <a class="btn btn-primary" :href="batchCreateInvoicePath">{{ $t('invoice.batch_create') }}</a>
        <a class="btn btn-primary ml-2" :href="newInvoicePath">{{ $t('invoice.add_invoice') }}</a>
      </div>
      <div class="ml-auto">
        <Paginator
          :currentPage="currentPage"
          :showPaginate="showPaginate"
          :totalPages="totalPages"
          :loadObjects="loadInvoices"
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
  import { mapState } from 'vuex'
  import TableInvoice from './component_invoices/tableInvoices.vue'
  import Paginator from './components/paginator.vue'

  export default  {
    components: {
      TableInvoice,
      Paginator,
    },
    data: function() {
      return {
        batchCreateInvoicePath: `/${locale}/batch_create/invoices/new`,
        newInvoicePath: `/${locale}/invoices/new`,
      }
    },
    computed: {
      ...mapState({
        params: state => state.invoice.params,
        totalPages: state => state.invoice.totalPages,
        showPaginate: state => state.invoice.showPaginate,
        invoices: state => state.invoice.invoices,
      }),
      currentPage: {
        get() {
          return this.$store.state.invoice.currentPage
        },
        set(val) {
          this.$store.commit('invoice/setCurrentPage', val)
        }
      }
    },
    created: function() {
      this.$store.dispatch('invoice/getInvoices')
    },
    methods: {
      loadInvoices: function(current_page) {
        this.$store.dispatch('invoice/submitFormSearch', { params: this.params, page: current_page })
      }
    }
  }
</script>
