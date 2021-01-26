<template>
  <div class="modal fade" id="detailContract" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">
            {{ $t('contract.detail_contract') }}
            <strong>
              {{ $t('contract.room_number') }}
              {{contract.room_number}}
            </strong>
          </h5>
        </div>
        <div class="modal-body">
          <div class="form-row">
            <FieldOnlyView id="id" :labelText="$t('contract.id')" colField="col-md-6"
              :value="contract.id"
            />
            <FieldOnlyView id="holder" :labelText="$t('contract.holder_name')" colField="col-md-6"
              :value="contract.holder_name"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="room_price" :labelText="$t('contract.room_price')" colField="col-md-6"
              :value="contract.room_price | formatNumber"
            />
            <FieldOnlyView id="deposited" :labelText="$t('contract.deposited_money')" colField="col-md-6"
              :value="contract.deposited_money | formatNumber"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="start_date" :labelText="$t('contract.start_date')" colField="col-md-6"
              :value="contract.start_date"
            />
            <FieldOnlyView id="end_date" :labelText="$t('contract.end_date')" colField="col-md-6"
              :value="contract.end_date"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="months_rented" :labelText="$t('contract.month_rented')" colField="col-md-6"
              :value="detail.months_rented"
            />
            <FieldOnlyView id="months_remaining" :labelText="$t('contract.month_remain')" colField="col-md-6"
              :value="detail.months_remaining"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="total_moneys" :labelText="$t('contract.total_money')"
              :value="detail.total_moneys | formatNumber"
            />
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ $t('contract.close') }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import FieldOnlyView from '../components/fieldOnlyView'

export default {
  components: {
    FieldOnlyView
  },
  data: function() {
    return {
      contract: {},
      detail: {}
    }
  },
  computed: {
    ...mapState({
      detailContract: state => state.contract.detailContract,
    })
  },
  watch: {
    detailContract: function(val) {
      this.contract = val.contract
      this.detail = val.detail
    }
  }
}
</script>
