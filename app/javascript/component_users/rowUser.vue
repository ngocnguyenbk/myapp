<template>
  <tbody :class="background_row_user(user, odd)">
    <tr>
      <td>{{user.id}}</td>
      <td>{{user.first_name}}</td>
      <td>{{user.last_name}}</td>
      <td>{{user.email}}</td>
      <td>{{user.phone}}</td>
      <td>{{user.birth_day}}</td>
      <td>{{user.created_date}}</td>
      <td>{{user.status_active}}</td>
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
  methods: {
    background_row_user: function(user, odd){
      if (user.status_active === true){
        return odd ? 'odd-bg' : 'even-bg'
      }
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
