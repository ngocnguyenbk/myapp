<template>
  <div
    id="editInvoice"
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
            {{ $t("invoice.edit_invoice") }} {{ $t("invoice.room") }}
            <strong>{{ currentInvoice.room_number }}</strong>
            {{ $t("invoice.month") }}
            <strong>{{ currentInvoice.month }}</strong>
          </h5>
        </div>
        <div v-show="isRegistration">
          <div class="modal-body">
            <FieldConfirm
              :label-text="$t('invoice.room_price')"
              :value="currentInvoice.room_price | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="dayUsedPerMonth"
              input-id="day_used_per_month"
              :label-text="$t('invoice.day_used_per_month')"
              :value-input="currentInvoice.day_lived"
              :e-msg="deliverErrors('day_used_per_month')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="electricStart"
              input-id="electric_start"
              :label-text="$t('invoice.electric_start')"
              :value-input="currentInvoice.begin_number_ele | formatNumber"
              :e-msg="deliverErrors('electric_start')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="electricEnd"
              input-id="electric_end"
              :label-text="$t('invoice.electric_end')"
              :value-input="currentInvoice.end_number_ele | formatNumber"
              :e-msg="deliverErrors('electric_end')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="waterStart"
              input-id="water_start"
              :label-text="$t('invoice.water_start')"
              :value-input="currentInvoice.begin_number_wat | formatNumber"
              :e-msg="deliverErrors('water_start')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="waterEnd"
              input-id="water_end"
              :label-text="$t('invoice.water_end')"
              :value-input="currentInvoice.end_number_wat | formatNumber"
              :e-msg="deliverErrors('water_end')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="unitPriceInternet"
              input-id="unit_price_internet"
              :label-text="$t('invoice.unit_price_internet')"
              :value-input="currentInvoice.unit_price_internet | formatNumber"
              :e-msg="deliverErrors('unit_price_internet')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="unitPriceParkingFee"
              input-id="unit_price_parking_fee"
              :label-text="$t('invoice.unit_price_parking_fee')"
              :value-input="currentInvoice.unit_price_parking_fee | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="quantityParking"
              input-id="quantity_parking"
              :label-text="$t('invoice.quantity_parking')"
              :value-input="currentInvoice.qty_parking_fee | formatNumber"
              :e-msg="deliverErrors('quantity_parking')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="unitPriceServiceFee"
              input-id="unit_price_service_fee"
              :label-text="$t('invoice.unit_price_service_fee')"
              :value-input="currentInvoice.unit_price_service | formatNumber"
              :e-msg="deliverErrors('unit_price_service_fee')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              v-model="reduce"
              input-id="reduce"
              :label-text="$t('invoice.reduce')"
              :value-input="currentInvoice.reduce | formatNumber"
              :e-msg="deliverErrors('reduce')"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <InputText
              :input-id="'total'"
              :label-text="$t('invoice.total')"
              :value-input="total | formatNumber"
              :disabled="true"
              col-label="col-lg-3"
              col-input="col-lg-9"
            />
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-dismiss="modal"
            >
              {{ $t("invoice.close") }}
            </button>
            <button
              type="button"
              class="btn btn-primary"
              @click="submitConfirm"
            >
              {{ $t("invoice.submit") }}
            </button>
          </div>
        </div>
        <div v-show="isConfirm">
          <div class="modal-body">
            <FieldConfirm
              :label-text="$t('invoice.room_price')"
              :value="currentInvoice.room_price | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.day_used_per_month')"
              :value="editInvoice.day_used_per_month"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.electric_start')"
              :value="editInvoice.electric_start | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.electric_end')"
              :value="editInvoice.electric_end | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.water_start')"
              :value="editInvoice.water_start | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.water_end')"
              :value="editInvoice.water_end | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.unit_price_internet')"
              :value="editInvoice.unit_price_internet | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.unit_price_parking_fee')"
              :value="editInvoice.unit_price_parking_fee | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.quantity_parking')"
              :value="editInvoice.quantity_parking | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.unit_price_service_fee')"
              :value="editInvoice.unit_price_service_fee | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.reduce')"
              :value="editInvoice.reduce | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
            <FieldConfirm
              :label-text="$t('invoice.total')"
              :value="editInvoice.total | formatNumber"
              col-label="col-md-3"
              col-input="col-md-9"
            />
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              @click="backToRegistration"
            >
              {{ $t("invoice.back") }}
            </button>
            <button
              type="button"
              class="btn btn-primary"
              data-dismiss="modal"
              @click="submitForm"
            >
              {{ $t("invoice.save_change") }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {createNamespacedHelpers} from 'vuex';
const {mapState, mapActions} = createNamespacedHelpers('invoice');
import InputText from '../components/inputText.vue';
import FieldConfirm from '../components/fieldConfirm.vue';

import show_flash_mixins from '../mixins/show_flash';
export default {
  components: {
    InputText,
    FieldConfirm,
  },
  mixins: [show_flash_mixins],
  data: function() {
    return {
      isRegistration: true,
      isConfirm: false,
      roomPrice: 0,
      dayUsedPerMonth: 1,
      electricStart: 0,
      electricEnd: 0,
      waterStart: 0,
      waterEnd: 0,
      unitPriceInternet: 0,
      unitPriceParkingFee: 0,
      quantityParking: 0,
      unitPriceServiceFee: 0,
      reduce: 0,
      total: 0,
    };
  },
  computed: {
    ...mapState({
      currentInvoice: (state) => state.currentInvoice,
      isValid: (state) => state.isValid,
      errorMessages: (state) => state.errorMessages,
      editInvoice: (state) => state.editInvoice,
    }),
    eleTotal: function() {
      const electricQuantity = this.editInvoice.electric_end - this.editInvoice.electric_start;
      return electricQuantity > 0 ? electricQuantity * this.currentInvoice.unit_price_electric : 0;
    },
    watTotal: function() {
      const waterQuantity = this.editInvoice.water_end - this.editInvoice.water_start;
      return waterQuantity > 0 ? waterQuantity * this.currentInvoice.unit_price_water : 0;
    },
    totalDayInMonth: function() {
      return new Date(this.currentInvoice.month.split('/')[1], this.currentInvoice.month.split('/')[0], 0).getDate();
    },
    intTotal: function() {
      return ((this.editInvoice.unit_price_internet * this.editInvoice.day_used_per_month) / this.totalDayInMonth);
    },
    pafTotal: function() {
      return ((this.editInvoice.unit_price_parking_fee 
          * this.editInvoice.day_used_per_month 
          * this.editInvoice.quantity_parking) 
        / this.totalDayInMonth);
    },
    serTotal: function() {
      return ((this.editInvoice.unit_price_service_fee * this.editInvoice.day_used_per_month) / this.totalDayInMonth);
    },
    roomPriceTotal: function() {
      return ((this.currentInvoice.room_price * this.editInvoice.day_used_per_month) / this.totalDayInMonth);
    },
  },
  watch: {
    dayUsedPerMonth: function(val) {
      this.setInputEditInvoiceForm({day_used_per_month: numeral(val).value()});
      this.calculateTotal();
    },
    electricStart: function(val) {
      this.setInputEditInvoiceForm({electric_start: numeral(val).value()});
      this.calculateTotal();
    },
    electricEnd: function(val) {
      this.setInputEditInvoiceForm({electric_end: numeral(val).value()});
      this.calculateTotal();
    },
    waterStart: function(val) {
      this.setInputEditInvoiceForm({water_start: numeral(val).value()});
      this.calculateTotal();
    },
    waterEnd: function(val) {
      this.setInputEditInvoiceForm({water_end: numeral(val).value()});
      this.calculateTotal();
    },
    unitPriceInternet: function(val) {
      this.setInputEditInvoiceForm({unit_price_internet: numeral(val).value()});
      this.calculateTotal();
    },
    unitPriceParkingFee: function(val) {
      this.setInputEditInvoiceForm({unit_price_parking_fee: numeral(val).value()});
      this.calculateTotal();
    },
    quantityParking: function(val) {
      this.setInputEditInvoiceForm({quantity_parking: numeral(val).value()});
      this.calculateTotal();
    },
    unitPriceServiceFee: function(val) {
      this.setInputEditInvoiceForm({unit_price_service_fee: numeral(val).value()});
      this.calculateTotal();
    },
    reduce: function(val) {
      this.setInputEditInvoiceForm({reduce: numeral(val).value()});
      this.calculateTotal();
    },
    total: function(val) {
      this.setInputEditInvoiceForm({total: Math.round(numeral(val).value())});
    },
  },
  methods: {
    ...mapActions(['updateInvoice', 'setInputEditInvoiceForm']),
    submitConfirm: async function() {
      this.setInputEditInvoiceForm({id: this.currentInvoice.id});
      await this.updateInvoice({step: 'confirmation'});
      if (!this.isValid) return;

      this.isRegistration = false;
      this.isConfirm = true;
    },
    submitForm: async function() {
      await this.updateInvoice({step: 'done'});
      this.isRegistration = true;
      this.isConfirm = false;
      this.show_flash(this.isValid);
    },
    backToRegistration: function() {
      this.isConfirm = false;
      this.isRegistration = true;
    },
    deliverErrors: function(attribute) {
      if (!this.errorMessages[0]) return;

      return this.errorMessages[0][attribute];
    },
    calculateTotal: function() {
      this.total = this.roomPriceTotal 
                                  + this.eleTotal 
                                  + this.watTotal 
                                  + this.intTotal 
                                  + this.pafTotal 
                                  + this.serTotal 
                                  - this.editInvoice.reduce;
    },
  },
};
</script>
