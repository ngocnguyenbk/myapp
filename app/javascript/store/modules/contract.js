import contract from '../../api/contracts'
import mixin from '../../mixins/handle_errors'

const state = {
  contracts: [],
  showPaginate: false,
  totalPages: 0,
  currentPage: 0,
  rooms: {},
  users: {},
  errorMessases: {},
  isIndex: true
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
  setErrors(state, errorMessases) {
    state.errorMessases = errorMessases
  },
  setIsIndex(state, isIndex) {
    state.isIndex = isIndex
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}