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
  },
  isValid: true
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
  async editRoom({ commit, dispatch }, payload) {
    await floor.updateRoom(payload.params, data => {
      if (data.status === 'ok') {
        commit('setCurrentRoom', data.room)
        commit('setStatusResponse', true)
      } else {
        commit('setStatusResponse', false)
      }
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
