import contract from '../../api/contracts'
import mixin from '../../mixins/handle_errors'

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
  defaultMonth: {
    3: "3 months",
    6: "6 months",
    9: "9 months",
    12: "12 months"
  },
  isValid: true
}

const actions = {
  submitFormSearch({ commit }, payload) {
    commit('setParams', payload)
    contract.loadWithCondition({q: payload.params, page: payload.page}, data => { commit('setContracts', data) })
  },
  getContracts({ commit }) {
    contract.loadWithCondition({}, contracts => {
      commit('setContracts', contracts)
    })
  },
  getRooms({ commit }) {
    contract.loadRooms({}, rooms => {
      commit('setRooms', rooms)
    })
  },
  getUsers({ commit }) {
    contract.loadUsers({}, users => {
      commit('setUsers', users)
    })
  },
  createContract({ commit }, payload) {
    contract.createContract(payload.params, data => {
      if (data.status === 'ok') {
        window.location.href = '/contracts'
      } else {
        commit('setErrors', mixin.methods.handle_single_error(data.errors))
      }
    })
  },
  setIsIndex( { commit }, payload ) {
    commit('setIsIndex', payload)
  },
  getDetailContract({ commit }, payload) {
    contract.loadDetailContract(payload.id, data => {
      commit('setDetailContract', data)
    })
  },
  deleteContract({ dispatch, state }, payload ) {
    contract.deleteContract(payload.params, data => {
      dispatch('submitFormSearch', { params: state.params, page: state.currentPage })
    })
  },
  async extendContract({ state, commit, dispatch }, payload ) {
    await contract.extendContract(payload.params, data => {
      if (data.status === 'ok') {
        commit('setStatusResponse', true)
        dispatch('submitFormSearch', { params: state.params, page: state.currentPage })
      } else {
        commit('setStatusResponse', false)
        commit('setErrors', mixin.methods.handle_single_error(data.errors))
      }
    })
  }
}

const mutations = {
  setParams(state, payload) {
    state.params = payload.params
    state.currentPage = Number(payload.page)
  },
  setContracts(state, data) {
    state.currentPage = Number(data.current_page)
    state.totalPages = data.total_pages
    state.showPaginate = data.total_pages > 1
    state.contracts = data.data
  },
  setRooms(state, rooms) {
    state.rooms = rooms
  },
  setUsers(state, users) {
    state.users = users
  },
  setCurrentPage(state, page) {
    state.currentPage = Number(page)
  },
  setErrors(state, errorMessages) {
    state.errorMessages = errorMessages
  },
  setIsIndex(state, isIndex) {
    state.isIndex = isIndex
  },
  setDetailContract(state, detailContract) {
    state.detailContract = detailContract
  },
  setStatusResponse(state, status) {
    state.isValid = status
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
