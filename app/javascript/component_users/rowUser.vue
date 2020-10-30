<template>
  <tbody :class="background_row_user">
    <tr>
      <td>{{user.id}}</td>
      <td>{{user.first_name}}</td>
      <td>{{user.last_name}}</td>
      <td>{{user.email}}</td>
      <td>{{user.phone}}</td>
      <td>{{user.birth_day}}</td>
      <td>{{user.created_date}}</td>
      <td class="text-center">
        <div :class="['dot dot-sm ml-auto', status_user]"></div>
      </td>
    </tr>
  </tbody>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    },
    odd: {
      type: Boolean,
      required: true
    }
  },
  computed: {
    background_row_user: function(){
      return this.odd ? 'odd-bg' : 'even-bg'
    },
    status_user: function(){
      return this.user.status_active ? 'active' : 'inactive'
    }
  },
}
</script>

<style lang="scss" scoped>
</style>
