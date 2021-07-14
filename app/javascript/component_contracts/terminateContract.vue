<template>
  <div
    id="terminateContract"
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
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">
            {{ $t('contract.terminate_contract') }} <strong>{{ contract.id }}</strong>
          </h5>
        </div>
        <div class="modal-body">
          <span>
            {{ $t('contract.confirmation.perform_terminate_contract') }} 
            <span class="text-danger">{{ contract.id }}</span>?
          </span>
          <hr>
          <InputToggleSwitch
            v-model="confirm"
            :label-text="$t('contract.confirmation.yes')"
            input-id="confirm"
            @checked="confirm = $event"
          />
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-dismiss="modal"
          >
            {{ $t('contract.confirmation.close') }}
          </button>
          <button
            type="button"
            class="btn btn-danger btn-delete"
            data-dismiss="modal"
            @click="submitDelete"
          >
            {{ $t('contract.confirmation.yes') }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputToggleSwitch from '../components/inputToggleSwitch';
import show_flash_mixins from '../mixins/show_flash';

export default {
  components: {
    InputToggleSwitch,
  },
  mixins: [show_flash_mixins],
  data: function() {
    return {
      params: {},
      contract: {},
      confirm: false,
    };
  },
  computed: {
    ...mapState({
      currentContract: (state) => state.contract.detailContract,
      flashMsg: (state) => state.contract.flashMsg,
      isValid: (state) => state.contract.isValid,
    }),
  },
  watch: {
    currentContract: function(val) {
      this.confirm = false;
      this.contract = val.contract;
      this.params = {
        id: this.contract.id,
      };
    },
  },
  updated: function() {
    $('.btn-delete').prop('disabled', !this.confirm);
  },
  methods: {
    submitDelete: async function() {
      if (!this.confirm) return;
      await this.$store.dispatch('contract/deleteContract', {params: this.params});

      this.show_flash(this.isValid);
    },
  },
};
</script>
