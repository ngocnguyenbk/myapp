<template>
  <div class="new-invoice">
    <div>
      <div>
        <h3>{{ $t('invoice.new_invoice') }}</h3>
      </div>
      <hr/>
      <div>
        <form id="new-invoice" class="w-90 ml-auto mr-auto" @submit.prevent="submitForm">
          <div class="form-input p-2">
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputSelect2
                  :inputId="'room_id'"
                  :labelText="$t('invoice.room_number')"
                  :placeHolder="$t('invoice.select_room')"
                  :options="collectionRooms"
                  v-model="roomId"
                  :eMsg="deliverErrors('room_id')"
                  typeSelect="single_select"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'input_room_price'"
                  :labelText="$t('invoice.room_price')"
                  :valueInput="newInvoice.room_price | formatNumber"
                  :eMsg="deliverErrors('room_price')"
                  v-model="roomPrice"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputDate
                  :inputId="'month'"
                  :labelText="$t('invoice.month')"
                  :eMsg="deliverErrors('month')"
                  :language="$i18n.locale"
                  :dateFormat="'MM/yyyy'"
                  :minimumView="'month'"
                  :maximumView="'year'"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                  v-model="month"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'used_room_quantity'"
                  :labelText="$t('invoice.day_used_per_month')"
                  :valueInput="newInvoice.day_used_per_month"
                  :eMsg="deliverErrors('day_used_per_month')"
                  v-model="dayUsedPerMonth"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'electric_start'"
                  :labelText="$t('invoice.electric_start')"
                  :valueInput="newInvoice.electric_start"
                  :eMsg="deliverErrors('electric_start')"
                  v-model="electricStart"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'electric_end'"
                  :labelText="$t('invoice.electric_end')"
                  :valueInput="newInvoice.electric_end"
                  :eMsg="deliverErrors('electric_end')"
                  v-model="electricEnd"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'water_start'"
                  :labelText="$t('invoice.water_start')"
                  :valueInput="newInvoice.water_start"
                  :eMsg="deliverErrors('water_start')"
                  v-model="waterStart"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'water_end'"
                  :labelText="$t('invoice.water_end')"
                  :valueInput="newInvoice.water_end"
                  :eMsg="deliverErrors('water_end')"
                  v-model="waterEnd"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'unit_price_parking_fee'"
                  :labelText="$t('invoice.unit_price_parking_fee')"
                  :valueInput="newInvoice.unit_price_parking_fee | formatNumber"
                  :eMsg="deliverErrors('unit_price_parking_fee')"
                  v-model="unitParkingFee"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'quantity_parking'"
                  :labelText="$t('invoice.quantity_parking')"
                  :valueInput="newInvoice.quantity_parking"
                  :eMsg="deliverErrors('quantity_parking')"
                  v-model="quantityParking"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'unit_price_internet'"
                  :labelText="$t('invoice.unit_price_internet')"
                  :valueInput="newInvoice.unit_price_internet | formatNumber"
                  :eMsg="deliverErrors('unit_price_internet')"
                  v-model="unitPriceInternet"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'unit_price_service_fee'"
                  :labelText="$t('invoice.unit_price_service_fee')"
                  :valueInput="newInvoice.unit_price_service_fee | formatNumber"
                  :eMsg="deliverErrors('unit_price_service_fee')"
                  v-model="serviceFee"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'reduce'"
                  :labelText="$t('invoice.reduce')"
                  :valueInput="newInvoice.reduce"
                  :eMsg="deliverErrors('reduce')"
                  v-model="reduce"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
              <div class="form-group col-md-6">
                <InputText
                  :inputId="'total'"
                  :labelText="$t('invoice.total')"
                  :valueInput="newInvoice.total | formatNumber"
                  :eMsg="deliverErrors('total')"
                  :disabled="true"
                  v-model="total"
                  colLabel="col-lg-4"
                  colInput="col-lg-6"
                />
              </div>
            </div>
          </div>
          <button type="submit" class="btn btn-primary float-left mt-2">{{ $t('invoice.submit_form') }}</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { createNamespacedHelpers } from 'vuex'
const { mapState, mapActions } = createNamespacedHelpers('invoice')
import InputText from '../components/inputText'
import InputNumber from '../components/inputNumber'
import InputSelect2 from '../components/inputSelect2'
import InputDate from '../components/inputDate'
export default {
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
    }
  },
  computed: {
    ...mapState({
      collectionRooms: state => state.rooms,
      newInvoice: state => state.newInvoice,
      errorMessages: state => state.errorMessages,
    }),
    eleTotal: function() {
      let electricQuantity = this.newInvoice.electric_end - this.newInvoice.electric_start
      return electricQuantity > 0 ? electricQuantity * this.newInvoice.electric_unit_price : 0
    },
    watTotal: function() {
      let waterQuantity = this.newInvoice.water_end - this.newInvoice.water_start
      return waterQuantity > 0 ? waterQuantity * this.newInvoice.water_unit_price : 0
    },
    totalDayInMonth: function() {
      return new Date(new Date(this.month).getFullYear(), new Date(this.month).getMonth() + 1, 0).getDate()
    },
    intTotal: function() {
      return this.newInvoice.unit_price_internet * this.newInvoice.day_used_per_month / this.totalDayInMonth
    },
    pafTotal: function() {
      return this.newInvoice.unit_price_parking_fee * this.newInvoice.day_used_per_month * this.newInvoice.quantity_parking / this.totalDayInMonth
    },
    serTotal: function() {
      return this.newInvoice.unit_price_service_fee * this.newInvoice.day_used_per_month / this.totalDayInMonth
    },
    roomPriceTotal: function() {
      return this.newInvoice.room_price * this.newInvoice.day_used_per_month / this.totalDayInMonth
    }
  },
  watch: {
    month: function(val) {
      this.setInputNewInvoiceForm({ month: `${new Date(val).getMonth() + 1}/${new Date(val).getFullYear()}`, day_used_per_month: this.totalDayInMonth })
      this.calculateTotal()
    },
    roomId: function(val) {
      this.getRoom({ id: val })
      this.calculateTotal()
    },
    roomPrice: function(val) {
      this.setInputNewInvoiceForm({ room_price: numeral(val).value() })
      this.calculateTotal()
    },
    dayUsedPerMonth: function(val) {
      this.setInputNewInvoiceForm({ day_used_per_month: numeral(val).value() })
      this.calculateTotal()
    },
    electricStart: function(val) {
      this.setInputNewInvoiceForm({ electric_start: numeral(val).value() })
      this.calculateTotal()
    },
    electricEnd: function(val) {
      this.setInputNewInvoiceForm({ electric_end: numeral(val).value() })
      this.calculateTotal()
    },
    waterStart: function(val) {
      this.setInputNewInvoiceForm({ water_start: numeral(val).value() })
      this.calculateTotal()
    },
    waterEnd: function(val) {
      this.setInputNewInvoiceForm({ water_end: numeral(val).value() })
      this.calculateTotal()
    },
    unitPriceInternet: function(val) {
      this.setInputNewInvoiceForm({ unit_price_internet: numeral(val).value() })
      this.calculateTotal()
    },
    unitParkingFee: function(val) {
      this.setInputNewInvoiceForm({ unit_price_parking_fee: numeral(val).value() })
      this.calculateTotal()
    },
    quantityParking: function(val) {
      this.setInputNewInvoiceForm({ quantity_parking: numeral(val).value() })
      this.calculateTotal()
    },
    serviceFee: function(val) {
      this.setInputNewInvoiceForm({ unit_price_service_fee: numeral(val).value() })
      this.calculateTotal()
    },
    reduce: function(val) {
      this.setInputNewInvoiceForm({ reduce: numeral(val).value() })
      this.calculateTotal()
    },
    total: function(val) {
      this.setInputNewInvoiceForm({ total: numeral(val).value() })
    },
  },
  components: {
    InputText,
    InputNumber,
    InputSelect2,
    InputDate,
  },
  created: function(){
    this.getResoursePrice()
  },
  methods: {
    ...mapActions(['createInvoice', 'getRoom', 'setInputNewInvoiceForm', 'getResoursePrice']),
    submitForm: function() {
      this.createInvoice(this.newInvoice)
    },
    deliverErrors: function(attribute) {
      if (!this.errorMessages[0]) return

      return this.errorMessages[0][attribute]
    },
    calculateTotal: function() {
      this.total = this.roomPriceTotal + this.eleTotal + this.watTotal + this.intTotal + this.pafTotal + this.serTotal - this.newInvoice.reduce
    }
  },
}
</script>

<style lang="scss" scoped>
  .form-input {
    border: 2px solid#e8e7e7;
    background-color: #f3f3f3;
  }
</style>
