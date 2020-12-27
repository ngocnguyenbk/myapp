<template>
  <table class="table table-multi-body table-bordered" @contextmenu.prevent="$refs.menu.open($event)">
    <ContextMenu ref="menu">
      <ContextMenuItem @click.native="editUser()">{{ $t('user.edit_user') }}</ContextMenuItem>
      <ContextMenuItem @click.native="deleteUser()">{{ $t('user.delete_user') }}</ContextMenuItem>
    </ContextMenu>
    <thead class="table-header">
      <tr class="table-head">
        <td class="w-100px">{{ $t('user.user_id') }}</td>
        <td class="w-200px">{{ $t('user.first_name') }}</td>
        <td class="w-200px">{{ $t('user.last_name') }}</td>
        <td class="w-150px">{{ $t('user.room_number') }}</td>
        <td>{{ $t('user.email') }}</td>
        <td class="w-200px">{{ $t('user.phone') }}</td>
        <td class="w-120px">{{ $t('user.birthday') }}</td>
        <td class="w-120px">{{ $t('user.created_at') }}</td>
        <td class="w-120px">{{ $t('user.edit_or_delete') }}</td>
        <td class="w-60px">{{ $t('user.active') }}</td>
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
