<template>
  <div :id="content_room" class="d-flex flex-column" data-toggle="modal" data-target="#editRoom" @click="setCurrentRoom">
    <div :class="['dot dot-lg ml-auto', status_room]"></div>
    <div class="text-center">{{room.room_number}}</div>
    <div class="d-flex mt-auto">
      <div class="mr-auto p-2 w-100px">
        <i class="fas fa-home icon-color"></i>
        {{room.area}} m<sup>2</sup>
      </div>
      <div class="p-2">
        <i class="fas fa-users icon-color"></i>
        {{room.total_users}}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    room: {
      type: Object,
      required: true
    }
  },
  computed: {
    content_room: function() {
      return `content_room_${this.room.room_number}`
    },
    status_room: function() {
      return this.room.status
    }
  },
  methods: {
    setCurrentRoom: function() {
      this.$store.dispatch('floor/setCurrentRoom', this.room)
      this.$store.dispatch('floor/getUsers', {params: {room_id: this.room.id}})
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
