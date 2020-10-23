<template>
  <div>
    <RowFloor
      :floor="floor" v-for="(floor, index) in floors" :key="index"
    />
  </div>
</template>

<script>
import RowFloor from './rowFloor.vue'

export default {
  components: {
    RowFloor
  },
  props: {
    floors: {
      type: Array,
      required: true
    }
  }
}
</script>
