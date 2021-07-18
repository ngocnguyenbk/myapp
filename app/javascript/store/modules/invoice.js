import invoice from '../../api/invoices';
import mixin from '../../mixins/handle_errors';

const state = {
  params: {},
  invoices: [],
  showPaginate: false,
  totalPages: 0,
  totalCount: 0,
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
  flashMsg: '',
};

const actions = {
  submitFormSearch({commit}, payload) {
    commit('setParams', payload);
    invoice.loadWithCondition({q: payload.params, page: payload.page}, (data) => {
      commit('setInvoices', data);
    });
  },
  getInvoices({commit}) {
    invoice.loadWithCondition({}, (invoices) => {
      commit('setInvoices', invoices);
    });
  },
  getInvoiceForm({commit}, payload) {
    invoice.loadInvoiceForm(payload, (invoicesForm) => {
      commit('setInvoiceForm', invoicesForm);
    });
  },
  setInputForm({commit}, payload) {
    commit('setInputForm', payload);
  },
  async createInvoices({commit}, payload) {
    await invoice.createInvoices({params: payload.params, month: payload.month}, (data) => {
      if (data.status === 'ok') {
        window.location.href = '/invoices';
      } else if (data.status === 'not_allow') {
        commit('setFlashMessage', data.errors);
      }
    });
  },
  getRooms({commit}) {
    invoice.loadRooms({}, (rooms) => {
      commit('setRooms', rooms);
    });
  },
  async createInvoice({commit}, payload) {
    const requestPayload = Object.assign({}, payload);
    delete requestPayload['room_price'];
    await invoice.createInvoice(requestPayload, (data) => {
      if (data.status == 'ok') {
        window.location.href = '/invoices';
      } else if (data.status === 'not_allow') {
        commit('setFlashMessage', data.errors);
        dispatch('clearErrorMessages');
      } else {
        commit('setFlashMessage');
        commit('setErrors', mixin.methods.handle_errors({0: data.errors}));
      }
    });
  },
  setInputNewInvoiceForm({commit}, payload) {
    commit('setInputNewInvoice', payload);
  },
  getDetailInvoice({commit}, id) {
    invoice.loadDetailInvoice(id, (data) => {
      commit('setDetailInvoice', data);
    });
  },
  setCurrentInvoice({commit}, payload) {
    commit('setCurrentInvoice', payload);
  },
  async updateInvoice({commit, dispatch, state}, payload) {
    const params = {...(state.editInvoice), ...payload};
    await invoice.updateInvoice(params, (data) => {
      if (data.step === 'confirmation' && data.status === 'ok') {
        commit('setStatusResponse', true);
      } else if (data.step === 'confirmation' && data.status != 'ok') {
        commit('setStatusResponse', false);
        commit('setErrors', mixin.methods.handle_errors({0: data.errors}));
      } else if (data.step === 'done' && data.status === 'ok') {
        commit('setStatusResponse', true);
        dispatch('submitFormSearch', {params: state.params, page: state.currentPage});
      } else {
        commit('setStatusResponse', false);
        dispatch('submitFormSearch', {params: state.params, page: state.currentPage});
      }
    });
  },
  setInputEditInvoiceForm({commit}, payload) {
    commit('setInputEditInvoice', payload);
  },
  clearErrorMessages({commit}, _payload) {
    commit('clearErrorMessages');
  },
  deleteInvoice({commit, dispatch, state}, payload) {
    invoice.deleteInvoice(payload.params, (data) => {
      dispatch('submitFormSearch', {params: state.params, page: state.currentPage});
    });
  },
  getResourceInfo({dispatch}, payload) {
    invoice.getResourceInfo(payload, (data) => {
      dispatch('setInputNewInvoiceForm', data.build);
    });
  },
};

const mutations = {
  setParams(state, payload) {
    state.params = payload.params;
    state.currentPage = Number(payload.page);
  },
  setInvoiceForm(state, invoicesForm) {
    state.invoicesForm = invoicesForm.build;
  },
  setInputForm(state, payload) {
    state.inputForm[payload.roomNumber] = payload.form;
  },
  setInvoices(state, data) {
    state.currentPage = Number(data.current_page);
    state.totalPages = data.total_pages;
    state.totalCount = data.total_count;
    state.showPaginate = data.total_pages > 1;
    state.invoices = data.data;
  },
  setRooms(state, rooms) {
    state.rooms = rooms;
  },
  setErrors(state, errorMessages) {
    state.errorMessages = errorMessages;
  },
  setInputNewInvoice(state, payload) {
    for (const key in payload) {
      state.newInvoice[key] = payload[key];
    }
  },
  setDetailInvoice(state, data) {
    state.detailInvoice = data.invoice;
  },
  setCurrentInvoice(state, data) {
    state.currentInvoice = data;
  },
  setStatusResponse(state, status) {
    state.isValid = status;
  },
  setInputEditInvoice(state, payload) {
    for (const key in payload) {
      state.editInvoice[key] = payload[key];
    }
  },
  clearErrorMessages(state, _payload) {
    state.errorMessages = '';
  },
  setFlashMessage(state, msg = '') {
    state.flashMsg = msg;
  },
};

export default {
  namespaced: true,
  state,
  actions,
  mutations,
};
