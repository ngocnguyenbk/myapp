<template>
  <div id="app">
    <div class="text-right">
      <Paginator
        :currentPage="currentPage"
        :showPaginate="showPaginate"
        :totalPages="totalPages"
        :loadObjects="loadUsers"
      />
    </div>
    <TableUser
      :users="users"
    />
  </div>
</template>

<script>
import axios from 'axios'
import { mapState, mapActions } from 'vuex'
import TableUser from './component_users/tableUsers.vue'
import Paginator from './components/paginator.vue'

export default {
  components: {
    TableUser,
    Paginator
  },
  computed: {
    ...mapState({
      params: state => state.user.params,
      totalCount: state => state.user.totalCount,
      totalPages: state => state.user.totalPages,
      showPaginate: state => state.user.showPaginate,
      users: state => state.user.users,
    }),
    currentPage: {
      get() {
        return this.$store.state.user.currentPage
      },
      set(val) {
        this.$store.commit('user/setCurrentPage', val)
      }
    }
  },
  created: function() {
    this.$store.dispatch('user/getUsers')
  },
  methods: {
    loadUsers: function(current_page) {
      this.$store.dispatch('user/submitFormSearch', {params: this.params, page: current_page })
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
