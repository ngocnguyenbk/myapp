<template>
  <div id="app">
    <NewUsers />
  </div>
</template>

<script>
import NewUsers from './component_users/newUsers.vue';

export default {
  components: {
    NewUsers,
  },
  created: function() {
    this.$store.dispatch('user/getRooms');
  },
};
</script>
