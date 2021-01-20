<template>
  <div class="modal fade" id="extendContract" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content" v-show="isConfirm">
        <div class="modal-header">
          <h5 class="modal-title">{{ $t('contract.extend_contract') }} <strong>{{ contract.id }}</strong></h5>
        </div>
        <div class="modal-body">
          <span>{{ $t('contract.number_of_month') }}</span>
          <hr/>
          <InputRadioButtons inputId="choose_month" colInput="col-lg-12"
            :hasLabel="false"
            :options="months"
            :valueInput="params.number_months"
            v-model="params.number_months"
          />
          <div class="form-group">
            <span>{{ $t('contract.or_input') }}</span>
          </div>
          <InputNumber inputId="input_month" colInput="col-lg-12" max="12" min="0"
            :valueInput="params.number_months"
            v-model="params.number_months"
            :eMsg="errorMessages['number_months'] ? errorMessages['number_months'] : ''"
          />
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ $t('contract.close') }}</button>
          <button type="button" class="btn btn-danger" @click="submitConfirm">{{ $t('contract.confirm') }}</button>
        </div>
      </div>
      <div class="modal-content" v-show="isDone">
        <div class="modal-header">
          <h5 class="modal-title">{{ $t('contract.extend_contract') }} <strong>{{ contract.id }}</strong></h5>
        </div>
        <div class="modal-body">
          <FieldOnlyView id="number_months" :labelText="$t('contract.number_of_month')" colField="col-md-12"
            :value="params.number_months"
          />
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" @click="backToEdit">{{ $t('contract.back') }}</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal" @click="submitDone">{{ $t('contract.submit') }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import InputRadioButtons from '../components/inputRadioButtons'
import InputNumber from '../components/inputNumber'
import FieldOnlyView from '../components/fieldOnlyView'
import show_flash_mixins from '../mixins/show_flash'

export default {
  components: {
    InputRadioButtons,
    InputNumber,
    FieldOnlyView
  },
  computed: {
    ...mapState({
      currentContract: state => state.contract.detailContract,
      defaultMonth: state => state.contract.defaultMonth,
      errorMessages: state => state.contract.errorMessages,
      isValid: state => state.contract.isValid,
      flashMsg: state => state.contract.flashMsg,
    }),
    months: function() {
      const self = this
      return this.defaultMonth.reduce(function(months, num) {
          months[num] = self.$tc('contract.defaultMonth.month', num)
          return months
        }
      , {} )
    }
  },
  data: function() {
    return {
      params: {},
      contract: {},
      isConfirm: true,
      isDone: false
    }
  },
  watch: {
    currentContract: function(val) {
      this.$store.commit('contract/setErrors', {})

      this.contract = val.contract
      this.params = {
        id: this.contract.id,
        number_months: '',
        step: ''
      }
    }
  },
  methods: {
    submitConfirm: async function() {
      this.params.step = 'confirmation'
      await this.$store.dispatch('contract/extendContract', { params: this.params })

      if (this.isValid) {
        this.isConfirm = false
        this.isDone = true
      }

      if (!this.flashMsg) return

      $('#extendContract').modal('toggle')
      this.show_flash(this.isValid)
    },
    submitDone: async function() {
      this.params.step = 'done'
      await this.$store.dispatch('contract/extendContract', { params: this.params })

      this.isConfirm = true
      this.isDone = false
      this.show_flash(this.isValid)
    },
    backToEdit: function() {
      this.isConfirm = true
      this.isDone = false
    }
  },
  mixins: [show_flash_mixins]
}
</script>

<style>

</style>
