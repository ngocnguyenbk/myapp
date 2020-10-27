import floor from '../../api/floors'

const state = {
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
