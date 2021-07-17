<template>
  <div class="new-invoice">
    <div>
      <div>
        <h3>{{ $t('invoice.new_invoice') }}</h3>
      </div>
      <hr>
      <div>
        <form
          id="new-invoice"
          class="w-90 ml-auto mr-auto"
          @submit.prevent="submitForm"
        >
          <div class="form-input p-2">
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputSelect2
                  v-model="roomId"
                  :input-id="'room_id'"
                  :label-text="$t('invoice.room_number')"
                  :place-holder="$t('invoice.select_room')"
                  :options="collectionRooms"
                  :e-msg="deliverErrors('room_id')"
                  type-select="single_select"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <FieldConfirm
                  :label-text="$t('invoice.room_price')"
                  :value="newInvoice.room_price | formatNumber"
                  col-label="col-md-4"
                  col-input="col-md-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputDate
                  v-model="month"
                  :input-id="'month'"
                  :label-text="$t('invoice.month')"
                  :e-msg="deliverErrors('month')"
                  :language="$i18n.locale"
                  :date-format="'MM/yyyy'"
                  :minimum-view="'month'"
                  :maximum-view="'year'"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  v-model="dayUsedPerMonth"
                  :input-id="'used_room_quantity'"
                  :label-text="$t('invoice.day_used_per_month')"
                  :value-input="newInvoice.day_used_per_month"
                  :e-msg="deliverErrors('day_used_per_month')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  v-model="electricStart"
                  :input-id="'electric_start'"
                  :label-text="$t('invoice.electric_start')"
                  :value-input="newInvoice.electric_start"
                  :e-msg="deliverErrors('electric_start')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  v-model="electricEnd"
                  :input-id="'electric_end'"
                  :label-text="$t('invoice.electric_end')"
                  :value-input="newInvoice.electric_end"
                  :e-msg="deliverErrors('electric_end')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  v-model="waterStart"
                  :input-id="'water_start'"
                  :label-text="$t('invoice.water_start')"
                  :value-input="newInvoice.water_start"
                  :e-msg="deliverErrors('water_start')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  v-model="waterEnd"
                  :input-id="'water_end'"
                  :label-text="$t('invoice.water_end')"
                  :value-input="newInvoice.water_end"
                  :e-msg="deliverErrors('water_end')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  v-model="unitParkingFee"
                  :input-id="'unit_price_parking_fee'"
                  :label-text="$t('invoice.unit_price_parking_fee')"
                  :value-input="newInvoice.unit_price_parking_fee | formatNumber"
                  :e-msg="deliverErrors('unit_price_parking_fee')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  v-model="quantityParking"
                  :input-id="'quantity_parking'"
                  :label-text="$t('invoice.quantity_parking')"
                  :value-input="newInvoice.quantity_parking"
                  :e-msg="deliverErrors('quantity_parking')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  v-model="unitPriceInternet"
                  :input-id="'unit_price_internet'"
                  :label-text="$t('invoice.unit_price_internet')"
                  :value-input="newInvoice.unit_price_internet | formatNumber"
                  :e-msg="deliverErrors('unit_price_internet')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  v-model="serviceFee"
                  :input-id="'unit_price_service_fee'"
                  :label-text="$t('invoice.unit_price_service_fee')"
                  :value-input="newInvoice.unit_price_service_fee | formatNumber"
                  :e-msg="deliverErrors('unit_price_service_fee')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  v-model="reduce"
                  :input-id="'reduce'"
                  :label-text="$t('invoice.reduce')"
                  :value-input="newInvoice.reduce"
                  :e-msg="deliverErrors('reduce')"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  v-model="total"
                  :input-id="'total'"
                  :label-text="$t('invoice.total')"
                  :value-input="newInvoice.total | formatNumber"
                  :e-msg="deliverErrors('total')"
                  :disabled="true"
                  col-label="col-lg-4"
                  col-input="col-lg-6"
                />
              </div>
            </div>
          </div>
          <button
            type="submit"
            class="btn btn-primary float-left mt-2"
          >
            {{ $t('invoice.submit_form') }}
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import {createNamespacedHelpers} from 'vuex';
const {mapState, mapActions} = createNamespacedHelpers('invoice');
import InputText from '../components/inputText';
import InputSelect2 from '../components/inputSelect2';
import InputDate from '../components/inputDate';
import FieldConfirm from '../components/fieldConfirm';
import show_flash_mixins from '../mixins/show_flash';

export default {
  components: {
    InputText,
    InputSelect2,
    InputDate,
    FieldConfirm,
  },
  mixins: [show_flash_mixins],
  data: function() {
    return {
      month: '',
      roomId: '',
      roomPrice: 0,
      dayUsedPerMonth: 1,
      electricStart: 0,
      electricEnd: 0,
      waterStart: 0,
      waterEnd: 0,
      unitPriceInternet: 0,
      unitParkingFee: 0,
      quantityParking: 0,
      serviceFee: 0,
      reduce: 0,
      total: 0,
    };
  },
  computed: {
    ...mapState({
      collectionRooms: (state) => state.rooms,
      newInvoice: (state) => state.newInvoice,
      errorMessages: (state) => state.errorMessages,
      flashMsg: (state) => state.flashMsg,
    }),
    eleTotal: function() {
      const electricQuantity = this.newInvoice.electric_end - this.newInvoice.electric_start;
      return electricQuantity > 0 ? electricQuantity * this.newInvoice.electric_unit_price : 0;
    },
    watTotal: function() {
      const waterQuantity = this.newInvoice.water_end - this.newInvoice.water_start;
      return waterQuantity > 0 ? waterQuantity * this.newInvoice.water_unit_price : 0;
    },
    totalDayInMonth: function() {
      return new Date(new Date(this.month).getFullYear(), new Date(this.month).getMonth() + 1, 0).getDate();
    },
    intTotal: function() {
      return this.newInvoice.unit_price_internet * this.newInvoice.day_used_per_month / this.totalDayInMonth;
    },
    pafTotal: function() {
      return this.newInvoice.unit_price_parking_fee 
      * this.newInvoice.day_used_per_month 
      * this.newInvoice.quantity_parking 
      / this.totalDayInMonth;
    },
    serTotal: function() {
      return this.newInvoice.unit_price_service_fee * this.newInvoice.day_used_per_month / this.totalDayInMonth;
    },
    roomPriceTotal: function() {
      return this.newInvoice.room_price * this.newInvoice.day_used_per_month / this.totalDayInMonth;
    },
  },
  watch: {
    month: function(val) {
      this.setInputNewInvoiceForm(
                    {month: `${new Date(val).getMonth() + 1}/${new Date(val).getFullYear()}`,
                    day_used_per_month: this.totalDayInMonth}
      );
      this.getResourceInfo({month: this.newInvoice.month, room_id: this.roomId});
      this.calculateTotal();
    },
    roomId: function(val) {
      this.setInputNewInvoiceForm({room_id: val});
      this.getResourceInfo({month: this.newInvoice.month, room_id: val});
      this.calculateTotal();
    },
    roomPrice: function(val) {
      this.setInputNewInvoiceForm({room_price: numeral(val).value()});
      this.calculateTotal();
    },
    dayUsedPerMonth: function(val) {
      this.setInputNewInvoiceForm({day_used_per_month: numeral(val).value()});
      this.calculateTotal();
    },
    electricStart: function(val) {
      this.setInputNewInvoiceForm({electric_start: numeral(val).value()});
      this.calculateTotal();
    },
    electricEnd: function(val) {
      this.setInputNewInvoiceForm({electric_end: numeral(val).value()});
      this.calculateTotal();
    },
    waterStart: function(val) {
      this.setInputNewInvoiceForm({water_start: numeral(val).value()});
      this.calculateTotal();
    },
    waterEnd: function(val) {
      this.setInputNewInvoiceForm({water_end: numeral(val).value()});
      this.calculateTotal();
    },
    unitPriceInternet: function(val) {
      this.setInputNewInvoiceForm({unit_price_internet: numeral(val).value()});
      this.calculateTotal();
    },
    unitParkingFee: function(val) {
      this.setInputNewInvoiceForm({unit_price_parking_fee: numeral(val).value()});
      this.calculateTotal();
    },
    quantityParking: function(val) {
      this.setInputNewInvoiceForm({quantity_parking: numeral(val).value()});
      this.calculateTotal();
    },
    serviceFee: function(val) {
      this.setInputNewInvoiceForm({unit_price_service_fee: numeral(val).value()});
      this.calculateTotal();
    },
    reduce: function(val) {
      this.setInputNewInvoiceForm({reduce: numeral(val).value()});
      this.calculateTotal();
    },
    total: function(val) {
      this.setInputNewInvoiceForm({total: numeral(val).value()});
    },
  },
  created: function() {
    this.getResourceInfo({});
  },
  methods: {
    ...mapActions(['createInvoice', 'setInputNewInvoiceForm', 'getResourceInfo']),
    submitForm: async function() {
      await this.createInvoice(this.newInvoice);

      if (!this.flashMsg) return;

      this.show_flash(false);
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
                                      - this.newInvoice.reduce;
    },
  },
};
</script>

<style lang="scss" scoped>
  .form-input {
    border: 2px solid#e8e7e7;
    background-color: #f3f3f3;
  }
</style>
