<template>
  <div class="bd-example w-100">
    <div class="btn-new-contract">
      <button class="btn btn-primary" @click="backToIndex">Back</button>
    </div>
    <hr/>
    <div class="d-flex">
      <h3>New contract</h3>
    </div>
    <hr/>
    <form id="new-contract" class="w-90 ml-auto mr-auto" @submit.prevent="submitForm">
      <div class="form-input p-2">
        <div class="form-row">
          <div class="form-group col-md-6">
            <InputSelect2 inputId="holder_id" placeHolder="Select holder" lableText="Holder name" typeSelect="single_select"
                          :options="collectionUsers"
                          :selected="holder_id"
                          v-model="holder_id"
                          :eMsg="errorMessases['holder_id']? errorMessases['holder_id'] : ''"
            />
          </div>
          <div class="form-group col-md-6">
            <InputSelect2 inputId="room_id" placeHolder="Select room" lableText="Room number" typeSelect="single_select"
                          :options="collectionRooms"
                          :selected="room_id"
                          v-model="room_id"
                          :eMsg="errorMessases['room_id']? errorMessases['room_id'] : ''"
            />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <InputNumberCurrency inputId="room_price" lableText="Room price" v-model="room_price"
                       :valueInput="room_price"
                       :eMsg="errorMessases['room_price']? errorMessases['room_price'] : ''"
            />
          </div>
          <div class="form-group col-md-6">
            <InputNumberCurrency inputId="deposited_money" lableText="Deposited" v-model="deposited_money"
                                 :valueInput="deposited_money"
            />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group col-md-6">
            <InputText inputId="started_date" lableText="Started date" v-model="started_date" typeInput="date"
                       :eMsg="errorMessases['started_date']? errorMessases['started_date'] : ''"
            />
          </div>
          <div class="form-group col-md-6">
            <InputText inputId="ended_date" lableText="Ended date" v-model="ended_date" typeInput="date"
                       :eMsg="errorMessases['ended_date']? errorMessases['ended_date'] : ''"
            />
          </div>
        </div>
      </div>
      <button class="btn btn-primary float-right mt-2">Submit</button>
    </form>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import InputText from '../components/inputText'
import InputSelect2 from '../components/inputSelect2'
import InputNumberCurrency from '../components/inputNumberCurrency'

export default {
  data: function() {
    return {
      holder_id: '',
      room_id: '',
      room_price: '',
      deposited_money: '',
      started_date: '',
      ended_date: ''
    }
  },
  components: {
    InputText,
    InputSelect2,
    InputNumberCurrency
  },
  computed: {
    ...mapState({
      collectionRooms: state => state.contract.rooms,
      collectionUsers: state => state.contract.users,
      errorMessases: state => state.contract.errorMessases,
      isIndex: state => state.contract.isIndex
    })
  },
  methods: {
    submitForm: function() {
      let params = {
        holder_id: this.holder_id,
        room_id: this.room_id,
        room_price: numeral(this.room_price).value(),
        deposited_money: numeral(this.deposited_money).value(),
        started_date: this.started_date,
        ended_date: this.ended_date
      }

      this.$store.dispatch('contract/createContract', { params: params })
    },
    backToIndex: function() {
      this.$store.dispatch('contract/setIsIndex', true)
    }
  }
}
</script>

<style lang="scss" scoped>
.form-input {
  border: 2px solid#e8e7e7;
  background-color: #f3f3f3;
}
</style>
