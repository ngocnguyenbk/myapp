<template>
  <div class="modal fade" id="editRoom" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Edit Room {{currentRoom.id}}</h5>
        </div>
        <div v-show="isRegistration">
          <div class="modal-body">
            <InputNumber inputId="room_number" lableText="Room number" :valueInput="params.room_number" v-model="params.room_number"/>
            <InputNumber inputId="area" lableText="Room area" :valueInput="params.area" v-model="params.area"/>
            <InputSelect2 inputId="holder_id" lableText="Room holder"
              :options="collectionUsers"
              :selected="params.holder_id"
              v-model="params.holder_id"
              typeSelect="single_select"
            />
            <InputRadioButtons inputId="status" lableText="Room status" :options="roomStatus" :valueInput="params.status" v-model="params.status"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" @click="submitConfirm">Submit</button>
          </div>
        </div>

        <div v-show="isConfirm">
          <div class="modal-body">
            <FieldConfirm lableText="Room number" :value="params.room_number"/>
            <FieldConfirm lableText="Area" :value="params.area"/>
            <FieldConfirm lableText="House holder" :value="collectionUsers[params.holder_id]"/>
            <FieldConfirm lableText="Room status" :value="roomStatus[params.status]"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" @click="backToConfirm">Back</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" @click="submitForm">Save changes</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import InputNumber from '../components/inputNumber.vue'
import InputRadioButtons from '../components/inputRadioButtons'
import InputSelect2 from '../components/inputSelect2.vue'
import FieldConfirm from '../components/fieldConfirm.vue'

export default {
  components: {
    InputNumber,
    InputRadioButtons,
    InputSelect2,
    FieldConfirm
  },
  computed: {
    ...mapState({
      currentRoom: state => state.floor.currentRoom,
      roomStatus: state => state.floor.roomStatus,
      collectionUsers: state => state.floor.users
    })
  },
  data: function(){
    return {
      isRegistration: true,
      isConfirm: false,
      params: {}
    }
  },
  watch: {
    currentRoom: function(val){
      this.params = {
        id: val.id,
        room_number: val.room_number,
        area: val.area,
        holder_id: val.holder_id,
        status: val.status
      }
    }
  },
  methods: {
    submitForm: function() {
      this.$store.dispatch('floor/submitFormData', { params: this.params})
      this.isRegistration = true
      this.isConfirm = false
    },
    submitConfirm: function() {
      this.isRegistration = false
      this.isConfirm = true
    },
    backToConfirm: function() {
      this.isConfirm = false
      this.isRegistration = true
    }
  }
}
</script>
