<template>
  <div>
    <span class="floor_name">Floor {{floor.floor_id}}</span>
    <div class="grid-container">
      <RowRoom :room="room" v-for="(room, index) in floor.rooms" :key="index"/>
    </div>
  </div>
</template>

<script>
import RowRoom from './rowRoom.vue'
export default {
  components: {
    RowRoom
  },
  props: {
    floor: {
      type: Object,
      required: true
    }
  }
}
</script>

<style lang="scss" scoped>

.grid-container {
  display: grid;
  grid-template-columns: auto auto auto auto auto;
  grid-gap: 1px;
  background-color: #2196F3;
  padding: 1px;
}

.grid-container > div {
  background-color: white;
  padding: 1px 0;
  font-size: 1rem;
  height: 150px;
}

.floor_name {
  font-size: 2rem;
}

</style>
