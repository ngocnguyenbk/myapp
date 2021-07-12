<template>
  <div class="modal fade" id="detailInvoice" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="true" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">
            {{ $t('invoice.detail_invoice') }}
            {{ $t('invoice.room_number') }}
            <strong>
              {{ invoice.room_number }}
            </strong>
            {{ $t('invoice.month') }}
            <strong>
              {{ invoice.month }}
            </strong>
          </h5>
        </div>
        <div class="modal-body">
          <div class="form-row">
            <FieldOnlyView
              :labelText="$t('invoice.invoice_id')"
              :value="invoice.id"
              :id="'id_' + invoice.id"
              colField="col-md-6"
            />
            <FieldOnlyView
              :labelText="$t('invoice.room_price')"
              :value="invoice.room_price | formatNumber"
              :id="'room_price_' + invoice.id "
              colField="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :labelText="$t('invoice.electric_start')"
              :value="invoice.begin_number_ele | formatNumber"
              :id="'electric_start_' + invoice.id"
              colField="col-md-6"
            />
            <FieldOnlyView
              :labelText="$t('invoice.electric_end')"
              :value="invoice.end_number_ele | formatNumber"
              :id="'electric_end_' + invoice.id"
              colField="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :labelText="$t('invoice.water_start')"
              :value="invoice.begin_number_wat | formatNumber"
              :id="'water_start_'+ invoice.id"
              colField="col-md-6"
            />
            <FieldOnlyView
              :labelText="$t('invoice.water_end')"
              :value="invoice.end_number_wat | formatNumber"
              :id="'water_end_'+ invoice.id"
              colField="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :labelText="$t('invoice.int_price')"
              :value="invoice.total_internet | formatNumber"
              :id="'total_internet_'+ invoice.id"
              colField="col-md-6"
            />
            <FieldOnlyView
              :labelText="$t('invoice.paf_price')"
              :value="invoice.total_parking_fee | formatNumber"
              :id="'total_parking_fee'+ invoice.id"
              colField="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :labelText="$t('invoice.ser_price')"
              :value="invoice.total_service | formatNumber"
              :id="'total_service_'+ invoice.id"
              colField="col-md-6"
            />
            <FieldOnlyView
              :labelText="$t('invoice.reduce')"
              :value="invoice.total_reduce | formatNumber"
              :id="'total_reduce_'+ invoice.id"
              colField="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :labelText="$t('invoice.total_income')"
              :value="invoice.total_revenue | formatNumber"
              :id="'total_revenue_'+ invoice.id"
              colField="col-md-12"
            />
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ $t('invoice.close') }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {createNamespacedHelpers} from 'vuex';
const {mapState} = createNamespacedHelpers('invoice');
import FieldOnlyView from '../components/fieldOnlyView';

export default {
  components: {
    FieldOnlyView,
  },
  data: function() {
    return {
      invoice: {},
    };
  },
  computed: {
    ...mapState({
      detailInvoice: (state) => state.detailInvoice,
    }),
  },
  watch: {
    detailInvoice: function(val) {
      this.invoice = val;
    },
  },
};
</script>
