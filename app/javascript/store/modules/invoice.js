import invoice from '../../api/invoices'

const state = {
  invoicesForm: {},
  inputForm: {}
}

const actions = {
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
  setInvoiceForm(state, invoicesForm) {
    state.invoicesForm = invoicesForm.build
  },
  setInputForm(state, payload) {
    state.inputForm[payload.roomNumber] = payload.form
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
