<template>
  <div class="modal fade" id="deleteUser" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Delete user <strong>{{ currentUser.full_name }}</strong></h5>
        </div>
        <div class="modal-body">
          <span>Do you want delete user <span class="text-danger">{{ currentUser.full_name }}</span>?</span>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal" @click="submitDelete">Delete</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
    ...mapState({
      currentUser: state => state.user.currentUser
    })
  },
  data: function() {
    return {
      params: {}
    }
  },
  watch: {
    currentUser: function(val) {
      this.params = {
        id: val.id
      }
    }
  },
  methods: {
    submitDelete: function() {
      this.$store.dispatch('user/deleteUser', { params: this.params })
    }
  }
}
</script>

<style>

</style>
