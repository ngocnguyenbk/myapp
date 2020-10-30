import user from '../../api/users'
import floor from '../../api/floors'

const state = {
  floors: [],
  currentRoom: {},
  users: {},
  roomStatus: {
    'hired': 'Hired',
    'deposited': 'Deposited',
    'empty': 'Empty'
  }
}

const actions = {
  getFloors({ commit }) {
    floor.loadWithCondition({}, floors => {
      commit('setFloors', floors)
    })
  },
  setCurrentRoom({ commit }, room) {
    commit('setCurrentRoom', room)
  },
  getUsers({ commit }, payload) {
    user.loadUsers(payload.params, users => {
      commit('setUsers', users)
    })
  },
  submitFormData({ commit, dispatch }, payload) {
    floor.updateRoom(payload.params, data => {
      commit('setForm', data)
      dispatch('getFloors', {})
    })
  }
}

const mutations = {
  setFloors(state, data) {
    state.floors = data.data
  },
  setCurrentRoom(state, room) {
    state.currentRoom = room
  },
  setUsers(state, users) {
    state.users = users
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
