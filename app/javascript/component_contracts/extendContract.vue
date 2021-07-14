<template>
  <div
    id="extendContract"
    class="modal fade"
    role="dialog"
    aria-modal="true"
    aria-hidden="true"
    data-backdrop="static"
    data-keyboard="false"
  >
    <div
      class="modal-dialog modal-dialog-centered"
      role="document"
    >
      <div
        v-show="isConfirm"
        class="modal-content"
      >
        <div class="modal-header">
          <h5 class="modal-title">
            {{ $t('contract.extend_contract') }} <strong>{{ contract.id }}</strong>
          </h5>
        </div>
        <div class="modal-body">
          <span>{{ $t('contract.number_of_month') }}</span>
          <hr>
          <InputRadioButtons
            v-model="params.number_months"
            input-id="choose_month"
            col-input="col-lg-12"
            :has-label="false"
            :options="months"
            :value-input="params.number_months"
          />
          <div class="form-group">
            <span>{{ $t('contract.or_input') }}</span>
          </div>
          <InputNumber
            v-model="params.number_months"
            input-id="input_month"
            col-input="col-lg-12"
            max="12"
            min="0"
            :value-input="params.number_months"
            :e-msg="errorMessages['number_months'] ? errorMessages['number_months'] : ''"
          />
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-dismiss="modal"
          >
            {{ $t('contract.close') }}
          </button>
          <button
            type="button"
            class="btn btn-danger"
            @click="submitConfirm"
          >
            {{ $t('contract.confirm') }}
          </button>
        </div>
      </div>
      <div
        v-show="isDone"
        class="modal-content"
      >
        <div class="modal-header">
          <h5 class="modal-title">
            {{ $t('contract.extend_contract') }} <strong>{{ contract.id }}</strong>
          </h5>
        </div>
        <div class="modal-body">
          <FieldOnlyView
            id="number_months"
            :label-text="$t('contract.number_of_month')"
            col-field="col-md-12"
            :value="params.number_months"
          />
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            @click="backToEdit"
          >
            {{ $t('contract.back') }}
          </button>
          <button
            type="button"
            class="btn btn-danger"
            data-dismiss="modal"
            @click="submitDone"
          >
            {{ $t('contract.submit') }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputRadioButtons from '../components/inputRadioButtons';
import InputNumber from '../components/inputNumber';
import FieldOnlyView from '../components/fieldOnlyView';
import show_flash_mixins from '../mixins/show_flash';

export default {
  components: {
    InputRadioButtons,
    InputNumber,
    FieldOnlyView,
  },
  mixins: [show_flash_mixins],
  data: function() {
    return {
      params: {},
      contract: {},
      isConfirm: true,
      isDone: false,
    };
  },
  computed: {
    ...mapState({
      currentContract: (state) => state.contract.detailContract,
      defaultMonth: (state) => state.contract.defaultMonth,
      errorMessages: (state) => state.contract.errorMessages,
      isValid: (state) => state.contract.isValid,
      flashMsg: (state) => state.contract.flashMsg,
    }),
    months: function() {
      const self = this;
      return this.defaultMonth.reduce(function(months, num) {
        months[num] = self.$tc('contract.defaultMonth.month', num);
        return months;
      }
      , {} );
    },
  },
  watch: {
    currentContract: function(val) {
      this.$store.commit('contract/setErrors', {});

      this.contract = val.contract;
      this.params = {
        id: this.contract.id,
        number_months: '',
        step: '',
      };
    },
  },
  methods: {
    submitConfirm: async function() {
      this.params.step = 'confirmation';
      await this.$store.dispatch('contract/extendContract', {params: this.params});

      if (this.isValid) {
        this.isConfirm = false;
        this.isDone = true;
      }

      if (!this.flashMsg) return;

      $('#extendContract').modal('toggle');
      this.show_flash(this.isValid);
    },
    submitDone: async function() {
      this.params.step = 'done';
      await this.$store.dispatch('contract/extendContract', {params: this.params});

      this.isConfirm = true;
      this.isDone = false;
      this.show_flash(this.isValid);
    },
    backToEdit: function() {
      this.isConfirm = true;
      this.isDone = false;
    },
  },
};
</script>
