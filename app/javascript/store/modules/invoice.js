import invoice from '../../api/invoices'

const state = {
  params: {},
  invoices: [],
  showPaginate: false,
  totalPages: 0,
  currentPage: 0,
  invoicesForm: {},
  inputForm: {},
}

const actions = {
  submitFormSearch({ commit }, payload) {
    commit('setParams', payload)
    invoice.loadWithCondition({q: payload.params, page: payload.page}, data => { commit('setInvoices', data) })
  },
  getInvoices({ commit }) {
    invoice.loadWithCondition({}, invoices => {
      commit('setInvoices', invoices)
    })
  },
  getInvoiceForm({ commit }) {
    invoice.loadInvoiceForm({}, invoicesForm => {
      commit('setInvoiceForm', invoicesForm)
    })
  },
  setInputForm({ commit }, payload){
    commit('setInputForm', payload)
  },
  createInvoices({ commit }, payload) {
    invoice.createInvoices(payload.params, data => {
      if (data.status === 'ok') {
        window.location.href = '/contracts'
      }
    })
  }
}

const mutations = {
  setParams(state, payload) {
    state.params = payload.params
    state.currentPage = Number(payload.page)
  },
  setInvoiceForm(state, invoicesForm) {
    state.invoicesForm = invoicesForm.build
  },
  setInputForm(state, payload) {
    state.inputForm[payload.roomNumber] = payload.form
  },
  setInvoices(state, data) {
    state.currentPage = Number(data.currentPage)
    state.totalPages = data.total_pages
    state.showPaginate = data.total_pages > 1
    state.invoices = data.data
  },
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
