<template>
  <tbody :class="background_row_user" @contextmenu.prevent="setCurrentUser">
    <tr>
      <td>{{user.id}}</td>
      <td>{{user.first_name}}</td>
      <td>{{user.last_name}}</td>
      <td>{{user.email}}</td>
      <td>{{user.phone}}</td>
      <td>{{user.birth_day}}</td>
      <td>{{user.created_date}}</td>
      <td class="text-center">
        <i class="fas fa-edit text-primary pointer mr-2"
           data-toggle="modal"
           data-target="#editUser"
           @click="setCurrentUser"
        />
        <i :class="['far fa-stop-circle text-danger ml-2', user.status_active ? 'pointer' : 'pointer_disable']"
           data-toggle="modal"
           data-target="#deleteUser"
           @click="setCurrentUser"
        />
      </td>
      <td class="text-center">
        <div :class="['dot dot-sm ml-auto align-middle', status_user]"></div>
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
    background_row_user: function() {
      return this.odd ? 'odd-bg' : 'even-bg'
    },
    status_user: function() {
      return this.user.status_active ? 'active' : 'inactive'
    }
  },
  methods: {
    setCurrentUser: function() {
      this.$store.dispatch('user/setCurrentUser', this.user)
    }
  }
}
</script>

<style lang="scss" scoped>
  .pointer {
    cursor: pointer;
  }

  .pointer_disable {
    pointer-events: none;
    color: gray !important;
  }
</style>
