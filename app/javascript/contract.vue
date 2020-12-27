<template>
  <div id="app">
    <FlashMessage :position="'right top'"></FlashMessage>
    <div class="table-contract" v-if="isIndex">
      <div class="d-flex">
        <div :class="['btn-new-contract', { 'mb-2': !showPaginate }]">
          <button class="btn btn-primary" @click="createForm">New contract</button>
        </div>
        <div class="ml-auto">
          <Paginator
            :currentPage="currentPage"
            :showPaginate="showPaginate"
            :totalPages="totalPages"
            :loadObjects="loadContracts"
          />
        </div>
      </div>
      <TableContract
        :contracts="contracts"
      />
    </div>
    <div class="new-contract" v-else>
      <div class="d-flex">
        <NewContract />
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import TableContract from './component_contracts/tableContracts'
import NewContract from './component_contracts/newContract'
import Paginator from './components/paginator'

export default {
  components: {
    TableContract,
    NewContract,
    Paginator
  },
  computed: {
    ...mapState({
      totalPages: state => state.contract.totalPages,
      showPaginate: state => state.contract.showPaginate,
      contracts: state => state.contract.contracts,
      isIndex: state => state.contract.isIndex
    }),
    currentPage: {
      get() {
        return this.$store.state.contract.currentPage
      },
      set(val) {
        this.$store.commit('contract/setCurrentPage', val)
      }
    }
  },
  created: function() {
    this.$store.dispatch('contract/getContracts')
    this.$store.dispatch('contract/getRooms')
    this.$store.dispatch('contract/getUsers')
  },
  methods: {
    loadContracts: function(current_page) {
      this.$store.dispatch('contract/submitFormSearch', { params: this.params, page: current_page })
    },
    createForm: function() {
      this.$store.dispatch('contract/setIsIndex', false)
    }
  }
}
</script>
