<template>
  <div
    id="detailInvoice"
    class="modal fade"
    role="dialog"
    aria-modal="true"
    aria-hidden="true"
    data-backdrop="true"
    data-keyboard="false"
  >
    <div
      class="modal-dialog modal-dialog-centered modal-lg"
      role="document"
    >
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
              :id="'id_' + invoice.id"
              :label-text="$t('invoice.invoice_id')"
              :value="invoice.id"
              col-field="col-md-6"
            />
            <FieldOnlyView
              :id="'room_price_' + invoice.id "
              :label-text="$t('invoice.room_price')"
              :value="invoice.room_price | formatNumber"
              col-field="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :id="'electric_start_' + invoice.id"
              :label-text="$t('invoice.electric_start')"
              :value="invoice.begin_number_ele | formatNumber"
              col-field="col-md-6"
            />
            <FieldOnlyView
              :id="'electric_end_' + invoice.id"
              :label-text="$t('invoice.electric_end')"
              :value="invoice.end_number_ele | formatNumber"
              col-field="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :id="'water_start_'+ invoice.id"
              :label-text="$t('invoice.water_start')"
              :value="invoice.begin_number_wat | formatNumber"
              col-field="col-md-6"
            />
            <FieldOnlyView
              :id="'water_end_'+ invoice.id"
              :label-text="$t('invoice.water_end')"
              :value="invoice.end_number_wat | formatNumber"
              col-field="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :id="'total_internet_'+ invoice.id"
              :label-text="$t('invoice.int_price')"
              :value="invoice.total_internet | formatNumber"
              col-field="col-md-6"
            />
            <FieldOnlyView
              :id="'total_parking_fee'+ invoice.id"
              :label-text="$t('invoice.paf_price')"
              :value="invoice.total_parking_fee | formatNumber"
              col-field="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :id="'total_service_'+ invoice.id"
              :label-text="$t('invoice.ser_price')"
              :value="invoice.total_service | formatNumber"
              col-field="col-md-6"
            />
            <FieldOnlyView
              :id="'total_reduce_'+ invoice.id"
              :label-text="$t('invoice.reduce')"
              :value="invoice.total_reduce | formatNumber"
              col-field="col-md-6"
            />
          </div>
          <div class="form-row">
            <FieldOnlyView
              :id="'total_revenue_'+ invoice.id"
              :label-text="$t('invoice.total_income')"
              :value="invoice.total_revenue | formatNumber"
              col-field="col-md-12"
            />
          </div>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-dismiss="modal"
          >
            {{ $t('invoice.close') }}
          </button>
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
