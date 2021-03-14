import invoice from '../../api/invoices'
import mixin from '../../mixins/handle_errors'

const state = {
  params: {},
  invoices: [],
  showPaginate: false,
  totalPages: 0,
  currentPage: 0,
  invoicesForm: {},
  inputForm: {},
  rooms: {},
  newInvoice: {
    month: '',
    room_id: '',
    room_price: '',
    day_used_per_month: '',
    electric_start: '',
    electric_end: '',
    water_start: '',
    water_end: '',
    unit_price_internet: '',
    unit_price_parking_fee: '',
    quantity_parking: '',
    unit_price_service_fee: '',
    reduce: '',
    total: '',
    electric_unit_price: 0,
    water_unit_price: 0,
  },
  currentInvoice: {},
  detailInvoice: {},
  errorMessages: {},
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
        window.location.href = '/invoices'
      }
    })
  },
  getRooms({ commit }) {
    invoice.loadRooms({}, rooms => {
      commit('setRooms', rooms)
    })
  },
  createInvoice({ commit }, payload) {
    invoice.createInvoice(payload, data => {
      if (data.status == 'ok') {
        window.location.href = '/invoices'
      } else {
        commit('setErrors', mixin.methods.handle_errors({ 0: data.errors }))
      }
    })
  },
  getRoom({ commit }, payload) {
    invoice.loadOneRoom(payload, data => {
      if (data.status == 'ok') {
        console.log(data)
        commit('setInputNewInvoice', data.data)
      }
    })
  },
  setInputNewInvoiceForm({ commit }, payload) {
    commit('setInputNewInvoice', payload)
  },
  getResoursePrice({ commit }) {
    invoice.getResourcePrice({}, data => {
      commit('setResourceUnitPrice', data)
    })
  },
  getDetailInvoice({ commit }, id) {
    invoice.loadDetailInvoice(id, data => {
      commit('setDetailInvoice', data)
    })
  },
  setCurrentInvoice({ commit }, payload) {
    commit('setCurrentInvoice', payload)
  },
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
  setRooms(state, rooms) {
    state.rooms = rooms
  },
  setErrors(state, errorMessages) {
    state.errorMessages = errorMessages
  },
  setInputNewInvoice(state, payload) {
    for (const key in payload) {
      state.newInvoice[key] = payload[key]
    }
  },
  setResourceUnitPrice(state, payload) {
    state.newInvoice.electric_unit_price = payload.build.electric_unit_price
    state.newInvoice.water_unit_price = payload.build.water_unit_price
  },
  setDetailInvoice(state, data) {
    state.detailInvoice = data.invoice
  },
  setCurrentInvoice(state, data) {
    state.currentInvoice = data
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
