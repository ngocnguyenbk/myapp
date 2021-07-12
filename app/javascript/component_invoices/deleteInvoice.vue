<template>
  <div class="modal fade" id="deleteInvoice" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content" v-if="currentInvoice.active">
        <div class="modal-header">
          <h5 class="modal-title">{{ $t('invoice.delete_invoice') }} <strong>{{ currentInvoice.id }}</strong></h5>
        </div>
        <div class="modal-body">
          <span>{{ $t('invoice.confirmation.perform_delete_invoice') }} <span class="text-danger">{{ currentInvoice.id }}</span>?</span>
          <hr/>
          <InputToggleSwitch :labelText="$t('invoice.confirmation.yes')" inputId="confirm" v-model="confirm" @checked="confirm = $event"/>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ $t('invoice.confirmation.close') }}</button>
          <button type="button" class="btn btn-danger btn-delete" data-dismiss="modal" @click="submitDelete">{{ $t('invoice.delete_invoice') }}</button>
        </div>
      </div>
      <div class="modal-content" v-else>
        <div class="modal-header">
          <h5 class="modal-title">{{ $t('invoice.info') }}</h5>
        </div>
        <div class="modal-body">
          <span>{{ $t('invoice.self') }} <strong class="text-danger">{{ currentInvoice.id }}</strong> {{ $t('invoice.deleted') }}</span>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ $t('invoice.confirmation.close') }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputToggleSwitch from '../components/inputToggleSwitch';
export default {
  components: {
    InputToggleSwitch,
  },
  computed: {
    ...mapState({
      currentInvoice: (state) => state.invoice.currentInvoice,
    }),
  },
  data: function() {
    return {
      params: {},
      confirm: false,
    };
  },
  watch: {
    currentInvoice: function(val) {
      this.confirm = false;
      this.params = {
        id: val.id,
      };
    },
  },
  methods: {
    submitDelete: function() {
      if (!this.confirm) return;
      this.$store.dispatch('invoice/deleteInvoice', {params: this.params});
    },
  },
  updated: function() {
    $('.btn-delete').prop('disabled', !this.confirm);
  },
};
</script>
