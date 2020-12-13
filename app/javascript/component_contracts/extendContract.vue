<template>
  <div class="modal fade" id="extendContract" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Extend contract <strong>{{ contract.id }}</strong></h5>
        </div>
        <div class="modal-body">
          <span>Number of months</span>
          <hr/>
          <InputRadioButtons inputId="choose_month" :hasLable="false" :options="defaultMonth" :valueInput="params.number_months" v-model="params.number_months"/>
          <div class="form-group">
            <span>or input</span>
          </div>
          <InputNumber inputId="input_month" colInput="col-lg-12" max="12"
            :valueInput="params.number_months"
            v-model="params.number_months"
            :eMsg="errorMessases['number_months']? errorMessases['number_months'] : ''"
          />
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-danger" @click="submitExtend">Extend contract</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import InputRadioButtons from '../components/inputRadioButtons'
import InputNumber from '../components/inputNumber'

import show_flash_mixins from '../mixins/show_flash'

export default {
  components: {
    InputRadioButtons,
    InputNumber
  },
  computed: {
    ...mapState({
      currentContract: state => state.contract.detailContract,
      defaultMonth: state => state.contract.defaultMonth,
      errorMessases: state => state.contract.errorMessases,
      isValid: state => state.contract.isValid
    })
  },
  data: function() {
    return {
      params: {},
      contract: {}
    }
  },
  watch: {
    currentContract: function(val) {
      this.contract = val.contract
      this.params = {
        id: this.contract.id,
        number_months: ''
      }
    }
  },
  methods: {
    submitExtend: async function() {
      await this.$store.dispatch('contract/extendContract', { params: this.params })

      if (this.isValid) {
        $('#extendContract').modal('hide')
      }
      this.show_flash(this.isValid)
    }
  },
  mixins: [show_flash_mixins]
}
</script>

<style>

</style>
