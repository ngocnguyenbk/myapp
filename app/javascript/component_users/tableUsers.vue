<template>
  <table class="table table-multi-body table-bordered" @contextmenu.prevent="$refs.menu.open($event)">
    <ContextMenu ref="menu">
      <ContextMenuItem @click.native="editUser()">Edit user</ContextMenuItem>
      <ContextMenuItem @click.native="deleteUser()">Delete user</ContextMenuItem>
    </ContextMenu>
    <thead class="table-header">
      <tr class="table-head">
        <td class="w-100px">User id</td>
        <td class="w-200px">First name</td>
        <td class="w-200px">Last name</td>
        <td class="w-150px">Room number</td>
        <td>Email</td>
        <td class="w-200px">Phone</td>
        <td class="w-120px">Birthday</td>
        <td class="w-120px">Created at</td>
        <td class="w-120px">Edit / Delete</td>
        <td class="w-60px">Active</td>
      </tr>
    </thead>
    <RowUser :user="user" :odd="(index % 2) != 0" v-for="(user, index) in users" :key="index" />
    <EditUser ref="modal_edit"/>
    <DeleteUser ref="modal_delete"/>
  </table>
</template>

<script>
import RowUser from './rowUser.vue'
import EditUser from './editUser.vue'
import DeleteUser from './deleteUser.vue'
import ContextMenu from '../components/contextMenu/contextMenu.vue'
import ContextMenuItem from '../components/contextMenu/contextMenuItem.vue'

export default {
  components: {
    RowUser,
    EditUser,
    DeleteUser,
    ContextMenu,
    ContextMenuItem
  },
  props: {
    users: {
      type: Array,
      required: true
    }
  },
  methods: {
    editUser: function() {
      let element = this.$refs.modal_edit.$el
      $(element).modal('show')
    },
    deleteUser: function() {
      let element = this.$refs.modal_delete.$el
      $(element).modal('show')
    }
  }
}
</script>
