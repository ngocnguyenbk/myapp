<template>
  <div id="app">
    <FlashMessage :position="'right top'" />
    <TableFloor
      :floors="floors"
    />
  </div>
</template>

<script>
import {mapState} from 'vuex';
import TableFloor from './component_floors/tableFloors.vue';

export default {
  components: {
    TableFloor,
  },
  computed: {
    ...mapState({
      floors: (state) => state.floor.floors,
    }),
  },
  created: function() {
    this.$store.dispatch('floor/getFloors');
  },
};
</script>
