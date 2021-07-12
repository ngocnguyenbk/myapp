import {data} from 'jquery';
import user from '../../api/users';
import mixin from '../../mixins/handle_errors';

const state = {
  params: {},
  users: [],
  showPaginate: false,
  totalPages: 0,
  currentPage: 0,
  currentUser: {},
  isValid: true,
  rooms: {},
  newUsers: [
    {
      first_name: '',
      last_name: '',
      email: '',
      phone: '',
      birthday: '',
      identity_card: '',
      room_id: '',
    },
  ],
  errorMessages: {},
  importUsers: {},
  errorsImportUsers: {},
};

const actions = {
  submitFormSearch({commit}, payload) {
    commit('setParams', payload);
    user.loadWithCondition({q: payload.params, page: payload.page}, (data) => {
      commit('setUsers', data);
    });
  },
  getUsers({commit}) {
    user.loadWithCondition({}, (users) => {
      commit('setUsers', users);
    });
  },
  setCurrentUser({commit}, user) {
    commit('setCurrentUser', user);
  },
  async editUser({commit, dispatch, state}, payload) {
    await user.updateUser(payload.params, (data) => {
      if (data.status === 'ok') {
        commit('setCurrentUser', data.user);
        commit('setStatusResponse', true);
      } else {
        commit('setStatusResponse', false);
      }
      dispatch('submitFormSearch', {params: state.params, page: state.currentPage});
    });
  },
  deleteUser({commit, dispatch, state}, payload) {
    user.deleteUser(payload.params, (data) => {
      dispatch('submitFormSearch', {params: state.params, page: state.currentPage});
    });
  },
  getRooms({commit}) {
    user.loadRooms({}, (rooms) => {
      commit('setRooms', rooms);
    });
  },
  setNewUser({commit}) {
    commit('setNewUser');
  },
  createUsers({commit}, payload) {
    user.createUsers(payload.params, (data) => {
      if (data.status === 'ok') {
        window.location.href = '/floors';
      } else {
        commit('setErrors', mixin.methods.handle_errors(data.errors));
      }
    });
  },
  deleteNewUser({commit}, index) {
    commit('deleteNewUser', index);
  },
  importFile({commit}, payload) {
    user.importFile(payload, (data) => {
      if (data.status === 'ok') {
        window.location.href = '/users';
      } else {
        commit('setResultImport', data);
      }
    });
  },
};

const mutations = {
  setParams(state, payload) {
    state.params = payload.params;
    state.currentPage = Number(payload.page);
  },
  setCurrentPage(state, page) {
    state.currentPage = Number(page);
  },
  setUsers(state, data) {
    state.currentPage = Number(data.current_page);
    state.totalPages = data.total_pages;
    state.showPaginate = data.total_pages > 1;
    state.users = data.data;
  },
  setCurrentUser(state, user) {
    state.currentUser = user;
  },
  setStatusResponse(state, status) {
    state.isValid = status;
  },
  setForm(state, params) {
    state.params = params;
  },
  setRooms(state, rooms) {
    state.rooms = rooms;
  },
  setNewUser(state) {
    state.newUsers.push({
      first_name: '',
      last_name: '',
      email: '',
      phone: '',
      birthday: '',
      identity_card: '',
      room_id: '',
    });
  },
  deleteNewUser(state, index) {
    state.newUsers.splice(index, 1);
  },
  setErrors(state, errorMessages) {
    state.errorMessages = errorMessages;
  },
  setResultImport(state, data) {
    state.importUsers = data.users;
    state.errorsImportUsers = data.errors;
  },
};

export default {
  namespaced: true,
  state,
  actions,
  mutations,
};
