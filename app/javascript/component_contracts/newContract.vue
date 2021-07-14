<template>
  <div class="bd-example w-100">
    <div class="btn-new-contract">
      <button
        class="btn btn-primary"
        @click="backToIndex"
      >
        {{ $t('contract.back') }}
      </button>
    </div>
    <hr>
    <div class="d-flex">
      <h3>{{ $t('contract.new_contract') }}</h3>
    </div>
    <hr>
    <form
      id="new-contract"
      class="w-90 ml-auto mr-auto"
      @submit.prevent="submitForm"
    >
      <div class="form-input p-2">
        <div class="form-row">
          <div class="form-group col-md-6">
            <InputSelect2
              v-model="holder_id"
              input-id="holder_id"
              :place-holder="$t('contract.select_holder')"
              :label-text="$t('contract.holder_name')"
              type-select="single_select"
              :options="collectionUsers"
              :selected="holder_id"
              :e-msg="errorMessages['holder_id']? errorMessages['holder_id'] : ''"
            />
          </div>
          <div class="form-group col-md-6">
            <InputSelect2
              v-model="room_id"
              input-id="room_id"
              :place-holder="$t('contract.select_room')"
              :label-text="$t('contract.room_number')"
              type-select="single_select"
              :options="collectionRooms"
              :selected="room_id"
              :e-msg="errorMessages['room_id']? errorMessages['room_id'] : ''"
            />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <InputNumberCurrency
              v-model="room_price"
              input-id="room_price"
              :label-text="$t('contract.room_price')"
              :value-input="room_price"
              :e-msg="errorMessages['room_price']? errorMessages['room_price'] : ''"
            />
          </div>
          <div class="form-group col-md-6">
            <InputNumberCurrency
              v-model="deposited_money"
              input-id="deposited_money"
              :label-text="$t('contract.deposited')"
              :value-input="deposited_money"
            />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <InputDate
              v-model="started_date"
              :input-id="'started_date'"
              :label-text="$t('contract.start_date')"
              :language="$i18n.locale"
              :e-msg="errorMessages['started_date']? errorMessages['started_date'] : ''"
            />
          </div>
          <div class="form-group col-md-6">
            <InputDate
              v-model="ended_date"
              :input-id="'ended_date'"
              :label-text="$t('contract.end_date')"
              :language="$i18n.locale"
              :value-input="ended_date"
              :e-msg="errorMessages['ended_date']? errorMessages['ended_date'] : ''"
            />
          </div>
        </div>
      </div>
      <button class="btn btn-primary float-right mt-2">
        {{ $t('contract.submit') }}
      </button>
    </form>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputSelect2 from '../components/inputSelect2';
import InputNumberCurrency from '../components/inputNumberCurrency';
import InputDate from '../components/inputDate';

export default {
  components: {
    InputSelect2,
    InputNumberCurrency,
    InputDate,
  },
  data: function() {
    return {
      holder_id: '',
      room_id: '',
      room_price: '',
      deposited_money: '',
      started_date: '',
      ended_date: '',
    };
  },
  computed: {
    ...mapState({
      collectionRooms: (state) => state.contract.rooms,
      collectionUsers: (state) => state.contract.users,
      errorMessages: (state) => state.contract.errorMessages,
      isIndex: (state) => state.contract.isIndex,
    }),
  },
  watch: {
    room_price: function(val) {
      this.deposited_money = val;
    },
    started_date: function(val) {
      const SIX_MONTH = 6;
      const target = new Date(val);
      target.setMonth(target.getMonth() + SIX_MONTH);
      this.ended_date = target;
    },
  },
  methods: {
    submitForm: function() {
      const params = {
        holder_id: this.holder_id,
        room_id: this.room_id,
        room_price: numeral(this.room_price).value(),
        deposited_money: numeral(this.deposited_money).value(),
        started_date: this.started_date,
        ended_date: this.ended_date,
      };

      this.$store.dispatch('contract/createContract', {params: params});
    },
    backToIndex: function() {
      this.$store.dispatch('contract/setIsIndex', true);
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
