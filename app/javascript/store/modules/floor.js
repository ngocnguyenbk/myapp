import floor from '../../api/floors'

const state = {
  params: {},
  floors: []
}

const actions = {
  getFloors({ commit }) {
    floor.loadWithCondition({}, floors => {
      commit('setFloors', floors)
    })
  }
}

const mutations = {
  setParams(state, payload) {
    state.params = payload.params
  },
  setFloors(state, data) {
    state.floors = data.data
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
