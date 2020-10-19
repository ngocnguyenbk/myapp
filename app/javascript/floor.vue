<template>
  <div id="app">
    BOARDING HOUSE MANAGEMENT SYSTEM
  </div>
</template>

<script>
import axios from 'axios'
import { mapState, mapActions } from 'vuex'

export default {
  computed: {
    ...mapState({
      params: state => state.floor.params,
      floors: state => state.floor.floors
    }),
  },
  created: function() {
    this.$store.dispatch('floor/getFloors')
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
