<template>
  <div :id="content_room" class="d-flex flex-column">
    <div :class="['dot dot-lg ml-auto', status_room]"></div>
    <div class="text-center">{{room.room_id}}</div>
    <div class="ml-auto mt-auto p-2">
      <i class="fas fa-users icon-color"></i>
      {{room.total_users}}
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
    content_room: function(){
      return `content_room_${this.room.room_id}`
    },
    status_room: function(){
      return this.room.status
    }
  }
}
</script>

<style lang="scss" scoped>

  $red-color: #D9534F;

  .dot{
    display: inline-block;
    border-radius: 50%;
    background-color: #EEE;

    &.hired{
      background-color: #449D44;
    }
    &.empty{
      animation:blinkingText 2s infinite;
      background-color: $red-color;
    }
    &.deposited{
      background-color: #F0AD4E;
    }
    &.dot-lg{
      margin: 4px 4px;
      height: 20px;
      width: 20px;
    }
  }

  @keyframes blinkingText{
    0%{ background-color: $red-color; }
    49%{ background-color: $red-color; }
    60%{ background-color: transparent; }
    99%{ background-color: transparent; }
    100%{ background-color: $red-color; }
  }

</style>
