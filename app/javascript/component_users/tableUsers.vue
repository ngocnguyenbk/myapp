<template>
  <table class="table table-multi-body table-bordered" @contextmenu.prevent="$refs.menu.open($event)">
    <ContextMenu ref="menu">
      <ContextMenuItem @click.native="editUser()">Edit user</ContextMenuItem>
      <ContextMenuItem @click.native="deleteUser()">Delete user</ContextMenuItem>
    </ContextMenu>
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
