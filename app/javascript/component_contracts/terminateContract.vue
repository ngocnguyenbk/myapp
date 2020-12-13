<template>
  <div class="modal fade" id="terminateContract" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Terminate contract <strong>{{ contract.id }}</strong></h5>
        </div>
        <div class="modal-body">
          <span>Do you want terminate contract <span class="text-danger">{{ contract.id }}</span>?</span>
          <hr/>
          <InputToggleSwitch labelText="Yes" inputId="confirm" v-model="confirm" @checked="confirm = $event"/>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-danger btn-delete" data-dismiss="modal" @click="submitDelete">Terminate</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import InputToggleSwitch from '../components/inputToggleSwitch'

export default {
  components: {
    InputToggleSwitch
  },
  computed: {
    ...mapState({
      currentContract: state => state.contract.detailContract
    })
  },
  data: function() {
    return {
      params: {},
      contract: {},
      confirm : false
    }
  },
  watch: {
    currentContract: function(val) {
      this.confirm = false
      this.contract = val.contract
      this.params = {
        id: this.contract.id
      }
    }
  },
  methods: {
    submitDelete: function() {
      if (!this.confirm) return
      this.$store.dispatch('contract/deleteContract', { params: this.params })
    }
  },
  updated: function() {
    $('.btn-delete').prop('disabled', !this.confirm)
  }
}
</script>

<style>

</style>
