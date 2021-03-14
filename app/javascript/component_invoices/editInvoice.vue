<template>
  <div class="modal fade" id="editInvoice" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="true" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{{ $t('invoice.edit_invoice') }} {{ $t('invoice.room') }} <strong>{{ currentInvoice.room_number }}</strong> {{ $t('invoice.month') }} <strong>{{ currentInvoice.month }}</strong></h5>
        </div>
        <div v-show="isRegistration">
          <div class="modal-body">
              <InputText
                inputId="room_price"
                :labelText="$t('invoice.room_price')"
                :valueInput="currentInvoice.room_price | formatNumber"
                v-model="params.room_price"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="day_used_per_month"
                :labelText="$t('invoice.day_used_per_month')"
                :valueInput="currentInvoice.day_used_per_month"
                v-model="params.day_used_per_month"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="electric_start"
                :labelText="$t('invoice.electric_start')"
                :valueInput="currentInvoice.begin_number_ele | formatNumber"
                v-model="params.electric_start"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="electric_end"
                :labelText="$t('invoice.electric_end')"
                :valueInput="currentInvoice.end_number_ele | formatNumber"
                v-model="params.electric_end"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="water_start"
                :labelText="$t('invoice.water_start')"
                :valueInput="currentInvoice.begin_number_wat | formatNumber"
                v-model="params.water_start"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="water_end"
                :labelText="$t('invoice.water_end')"
                :valueInput="currentInvoice.end_number_wat | formatNumber"
                v-model="params.water_end"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="unit_price_internet"
                :labelText="$t('invoice.unit_price_internet')"
                :valueInput="currentInvoice.unit_price_internet | formatNumber"
                v-model="params.unit_price_internet"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="unit_price_parking_fee"
                :labelText="$t('invoice.unit_price_parking_fee')"
                :valueInput="currentInvoice.unit_price_parking_fee | formatNumber"
                v-model="params.unit_price_parking_fee"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="quantity_parking"
                :labelText="$t('invoice.quantity_parking')"
                :valueInput="currentInvoice.quantity_parking | formatNumber"
                v-model="params.quantity_parking"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="unit_price_service_fee"
                :labelText="$t('invoice.unit_price_service_fee')"
                :valueInput="currentInvoice.unit_price_service_fee | formatNumber"
                v-model="params.unit_price_service_fee"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
              <InputText
                inputId="reduce"
                :labelText="$t('invoice.reduce')"
                :valueInput="currentInvoice.reduce | formatNumber"
                v-model="params.reduce"
                colLabel="col-md-3"
                colInput="col-md-9"
              />
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ $t('invoice.close') }}</button>
            <button type="button" class="btn btn-primary" @click="submitConfirm">{{ $t('invoice.submit') }}</button>
          </div>
        </div>
        <!-- <div v-show="isConfirm">
          <div class="modal-body">
              <FieldConfirm :labelText="$t('user.first_name')" :value="params.first_name"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" @click="backToRegistration">{{ $t('user.back') }}</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" @click="submitForm">{{ $t('user.save_change')}}</button>
          </div>
        </div> -->
      </div>
    </div>
  </div>
</template>

<script>
import { createNamespacedHelpers } from 'vuex'
const { mapState, mapActions } = createNamespacedHelpers('invoice')
import InputText from '../components/inputText.vue'
import show_flash_mixins from '../mixins/show_flash'
export default {
  components: {
    InputText,
  },
  computed: {
    ...mapState({
      currentInvoice: state => state.currentInvoice,
      // isValid: state => state.user.isValid
    })
  },
  data: function() {
    return {
      isRegistration: true,
      isConfirm: false,
      params: {}
    }
  },
  mixins: [show_flash_mixins],
  watch: {
    currentInvoice: function(val) {
      this.params = {
        id: val.id,
        room_price: val.room_price,
        day_used_per_month: val.day_used_per_month,
        electric_start: val.electric_start,
        electric_end: val.electric_end,
        water_start: val.water_start,
        water_end: val.water_end,
        unit_price_internet: val.unit_price_internet,
        unit_price_parking_fee: val.unit_price_parking_fee,
        quantity_parking: val.quantity_parking,
        unit_price_service_fee: val.unit_price_service_fee,
        reduce: val.reduce,
      }
    }
  },
  methods: {
    submitConfirm: function() {
      this.isRegistration = false
      this.isConfirm = true
    }
  },
}
</script>
