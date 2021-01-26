<template>
  <div>
    <RowFloor
      :floor="floor" v-for="(floor, index) in floors" :key="index"
    />
    <EditRoom />
  </div>
</template>

<script>
import RowFloor from './rowFloor.vue'
import EditRoom from './editRoom.vue'

export default {
  components: {
    RowFloor,
    EditRoom
  },
  props: {
    floors: {
      type: Array,
      required: true
    }
  }
}
</script>
