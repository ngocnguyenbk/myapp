import Vue from 'vue';
import Vuex from 'vuex';
import user from './modules/user';
import floor from './modules/floor';
import contract from './modules/contract';
import invoice from './modules/invoice';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    user,
    floor,
    contract,
    invoice,
  },
});
