<template>
  <div id="app">
    <div class="d-flex">
      <FlashMessage :position="'left top'" />
      <div :class="['new-user', { 'mb-2': !showPaginate }]">
        <a
          class="btn btn-primary"
          :href="newUserPath"
        >{{ $t('user.new_user') }}</a>
      </div>
      <div class="ml-auto">
        <Paginator
          :current-page="currentPage"
          :show-paginate="showPaginate"
          :total-pages="totalPages"
          :load-objects="loadUsers"
        />
      </div>
    </div>
    <TableUser
      :users="users"
    />
  </div>
</template>

<script>
import {mapState} from 'vuex';
import TableUser from './component_users/tableUsers.vue';
import Paginator from './components/paginator.vue';

export default {
  components: {
    TableUser,
    Paginator,
  },
  data: function() {
    return {
      newUserPath: `/${locale}/users/new`,
    };
  },
  computed: {
    ...mapState({
      params: (state) => state.user.params,
      totalPages: (state) => state.user.totalPages,
      showPaginate: (state) => state.user.showPaginate,
      users: (state) => state.user.users,
    }),
    currentPage: {
      get() {
        return this.$store.state.user.currentPage;
      },
      set(val) {
        this.$store.commit('user/setCurrentPage', val);
      },
    },
  },
  created: function() {
    this.$store.dispatch('user/getUsers');
  },
  methods: {
    loadUsers: function(current_page) {
      this.$store.dispatch('user/submitFormSearch', {params: this.params, page: current_page});
    },
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
