import contract from '../../api/contracts';
import mixin from '../../mixins/handle_errors';

const state = {
  contracts: [],
  showPaginate: false,
  totalPages: 0,
  currentPage: 0,
  rooms: {},
  users: {},
  errorMessages: {},
  isIndex: true,
  detailContract: {},
  defaultMonth: [3, 6, 9, 12],
  isValid: true,
  flashMsg: '',
};

const actions = {
  submitFormSearch({commit}, payload) {
    commit('setParams', payload);
    contract.loadWithCondition({q: payload.params, page: payload.page}, (data) => {
      commit('setContracts', data);
    });
  },
  getContracts({commit}) {
    contract.loadWithCondition({}, (contracts) => {
      commit('setContracts', contracts);
    });
  },
  getRooms({commit}) {
    contract.loadRooms({}, (rooms) => {
      commit('setRooms', rooms);
    });
  },
  getUsers({commit}) {
    contract.loadUsers({}, (users) => {
      commit('setUsers', users);
    });
  },
  createContract({commit}, payload) {
    contract.createContract(payload.params, (data) => {
      if (data.status === 'ok') {
        window.location.href = '/contracts';
      } else {
        commit('setErrors', mixin.methods.handle_single_error(data.errors));
      }
    });
  },
  setIsIndex( {commit}, payload ) {
    commit('setIsIndex', payload);
  },
  getDetailContract({commit}, payload) {
    contract.loadDetailContract(payload.id, (data) => {
      commit('setDetailContract', data);
    });
  },
  async deleteContract({commit, dispatch, state}, payload ) {
    await contract.deleteContract(payload.params, (data) => {
      if (data.status === 'unprocessable_entity') {
        commit('setStatusResponse', false);
        commit('setFlashMessage', data.errors);
      } else {
        commit('setStatusResponse', true);
        commit('setFlashMessage');
        dispatch('submitFormSearch', {params: state.params, page: state.currentPage});
      }
    });
  },
  async extendContract({state, commit, dispatch}, payload ) {
    await contract.extendContract(payload.params, (data) => {
      if (data.status === 'ok') {
        commit('setStatusResponse', true);
        commit('setFlashMessage');
        dispatch('submitFormSearch', {params: state.params, page: state.currentPage});
      } else if (data.status === 'unprocessable_entity') {
        commit('setStatusResponse', false);
        commit('setFlashMessage');
        commit('setErrors', mixin.methods.handle_single_error(data.errors));
      } else if (data.status === 'not_allow') {
        commit('setStatusResponse', false);
        commit('setFlashMessage', data.errors);
      }
    });
  },
};

const mutations = {
  setParams(state, payload) {
    state.params = payload.params;
    state.currentPage = Number(payload.page);
  },
  setContracts(state, data) {
    state.currentPage = Number(data.current_page);
    state.totalPages = data.total_pages;
    state.showPaginate = data.total_pages > 1;
    state.contracts = data.data;
  },
  setRooms(state, rooms) {
    state.rooms = rooms;
  },
  setUsers(state, users) {
    state.users = users;
  },
  setCurrentPage(state, page) {
    state.currentPage = Number(page);
  },
  setErrors(state, errorMessages) {
    state.errorMessages = errorMessages;
  },
  setIsIndex(state, isIndex) {
    state.isIndex = isIndex;
  },
  setDetailContract(state, detailContract) {
    state.detailContract = detailContract;
  },
  setStatusResponse(state, status) {
    state.isValid = status;
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
