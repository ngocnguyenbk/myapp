import { data } from 'jquery'
import user from '../../api/users'

const state = {
  params: {},
  users: [],
  showPaginate: false,
  totalPages: 0,
  totalCount: 0,
  currentPage: 0,
  currentUser: {}
}

const actions = {
  submitFormSearch({ commit }, payload) {
    commit('setParams', payload)
    user.loadWithCondition({q: payload.params, page: payload.page}, data => { commit('setUsers', data) })
  },
  getUsers({ commit }) {
    user.loadWithCondition({}, users => {
      commit('setUsers', users)
    })
  },
  setCurrentUser({ commit }, user) {
    commit('setCurrentUser', user)
  },
  submitFormData({ commit, dispatch, state }, payload) {
    user.updateUser(payload.params, data => {
      commit('setForm', data)
      dispatch('submitFormSearch', { params: state.params, page: state.currentPage })
    })
  },
  deleteUser({ commit, dispatch, state }, payload) {
    user.deleteUser(payload.params, data => {
      commit('setForm', data)
      dispatch('submitFormSearch', { params: state.params, page: state.currentPage })
    })
  }
}

const mutations = {
  setParams(state, payload) {
    state.params = payload.params
    state.currentPage = Number(payload.page)
  },
  setCurrentPage(state, page) {
    state.currentPage = Number(page)
  },
  setUsers(state, data) {
    state.currentPage = Number(data.current_page)
    state.totalPages = data.total_pages
    state.totalCount = data.total_count
    state.showPaginate = data.total_pages > 1
    state.users = data.data
  },
  setCurrentUser(state, user) {
    state.currentUser = user
  },
  setForm(state, params) {
    state.params = params
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
