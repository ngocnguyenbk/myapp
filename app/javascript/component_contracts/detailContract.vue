<template>
  <div class="modal fade" id="detailContract" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">
            Detail contract
            <strong>
              Room number
              {{contract.room_number}}
            </strong>
          </h5>
        </div>
        <div class="modal-body">
          <div class="form-row">
            <FieldOnlyView id="id" labelText="ID" colField="col-md-6"
              :value="contract.id"
            />
            <FieldOnlyView id="holder" labelText="Holder" colField="col-md-6"
              :value="contract.holder_name"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="room_price" labelText="Room price" colField="col-md-6"
              :value="contract.room_price | formatNumber"
            />
            <FieldOnlyView id="deposited" labelText="Deposited money" colField="col-md-6"
              :value="contract.deposited_money | formatNumber"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="start_date" labelText="Start date" colField="col-md-6"
              :value="contract.start_date"
            />
            <FieldOnlyView id="end_date" labelText="End date" colField="col-md-6"
              :value="contract.end_date"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="months_rented" labelText="Months rented" colField="col-md-6"
              :value="detail.months_rented"
            />
            <FieldOnlyView id="months_remaining" labelText="Months remaining" colField="col-md-6"
              :value="detail.months_remaining"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView id="total_moneys" labelText="Total moneys"
              :value="detail.total_moneys | formatNumber"
            />
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
