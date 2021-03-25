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
  editInvoice: {
    id: null,
    room_price: 0,
    day_used_per_month: 0,
    electric_start: 0,
    electric_end: 0,
    water_start: 0,
    water_end: 0,
    unit_price_internet: 0,
    unit_price_parking_fee: 0,
    quantity_parking: 0,
    unit_price_service_fee: 0,
    reduce: 0,
    total: 0,
  },
  currentInvoice: {},
  detailInvoice: {},
  errorMessages: {},
  isValid: true,
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
  async updateInvoice({ commit, dispatch, state }, payload) {
    const params = { ...(state.editInvoice), ...payload }
    await invoice.updateInvoice(params, data => {
      if (data.step === 'confirmation' && data.status === 'ok') {
        commit('setStatusResponse', true)
      } else if (data.step === 'confirmation' && data.status != 'ok') {
        commit('setStatusResponse', false)
        commit('setErrors', mixin.methods.handle_errors({ 0: data.errors }))
      } else if (data.step === 'done' && data.status === 'ok') {
        commit('setStatusResponse', true)
        dispatch('submitFormSearch', { params: state.params, page: state.currentPage })
      } else {
        commit('setStatusResponse', false)
        dispatch('submitFormSearch', { params: state.params, page: state.currentPage })
      }
    })
  },
  setInputEditInvoiceForm({ commit }, payload) {
    commit('setInputEditInvoice', payload)
  },
  clearErrorMessages({commit}, _payload) {
    commit('clearErrorMessages')
  },
  deleteInvoice({ commit, dispatch, state }, payload) {
    invoice.deleteInvoice(payload.params, data => {
      dispatch('submitFormSearch', { params: state.params, page: state.currentPage })
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
    state.currentPage = Number(data.current_page)
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
  },
  setStatusResponse(state, status) {
    state.isValid = status
  },
  setInputEditInvoice(state, payload) {
    for (const key in payload) {
      state.editInvoice[key] = payload[key]
    }
  },
  clearErrorMessages(state, _payload) {
    state.errorMessages = ''
  },
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
