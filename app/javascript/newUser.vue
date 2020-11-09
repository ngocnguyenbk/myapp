<template>
  <div id="app">
    <NewUsers />
  </div>
</template>

<script>
import axios from 'axios'
import { mapState, mapActions } from 'vuex'
import NewUsers from './component_users/newUsers.vue'
export default {
  components: {
    NewUsers
  },
  created: function() {
    this.$store.dispatch('user/getRooms')
  },
}
</script>
