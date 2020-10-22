<template>
  <table class="table table-multi-body">
    <thead class="table-header">
      <tr class="table-head">
        <td class="w-100px">USER ID</td>
        <td class="w-200px">FIRST NAME</td>
        <td class="w-200px">LAST NAME</td>
        <td>EMAIL</td>
        <td class="w-200px">PHONE</td>
        <td class="w-200px">BIRTHDAY</td>
        <td class="w-200px">CREATED AT</td>
        <td class="w-60px">ACTIVE</td>
      </tr>
    </thead>
    <RowUser :user="user" :odd="(index % 2) != 0" v-for="(user, index) in users" :key="index" />
  </table>
</template>

<script>
import RowUser from './rowUser.vue'

export default {
  components: {
    RowUser
  },
  props: {
    users: {
      type: Array,
      required: true
    }
  }
}
</script>
