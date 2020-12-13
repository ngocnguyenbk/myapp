<template>
  <div class="modal fade" id="editUser" role="dialog" aria-modal="true" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Edit user <strong>{{ currentUser.full_name }}</strong></h5>
        </div>
        <div v-show="isRegistration">
          <div class="modal-body">
              <InputText inputId="first_name" labelText="First name" :valueInput="params.first_name" v-model="params.first_name"/>
              <InputText inputId="last_name" labelText="Last name" :valueInput="params.last_name" v-model="params.last_name"/>
              <InputText inputId="email" labelText="Email" :valueInput="params.email" v-model="params.email"/>
              <InputText inputId="birthday" labelText="Birthday" :valueInput="params.birthday" v-model="params.birthday"/>
              <InputText inputId="phone" labelText="Phone" :valueInput="params.phone" v-model="params.phone"/>
              <InputText :inputId="'identity_card'" labelText="Identity card" v-model="params.identity_card" :valueInput="params.identity_card"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" @click="submitConfirm">Submit</button>
          </div>
        </div>
        <div v-show="isConfirm">
          <div class="modal-body">
              <FieldConfirm labelText="First name" :value="params.first_name"/>
              <FieldConfirm labelText="Last name" :value="params.last_name"/>
              <FieldConfirm labelText="Email" :value="params.email"/>
              <FieldConfirm labelText="Birthday" :value="params.birthday"/>
              <FieldConfirm labelText="Phone" :value="params.phone"/>
              <FieldConfirm labelText="Identity card" :value="params.identity_card"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" @click="backToRegistration">Back</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" @click="submitForm">Save changes</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import InputText from '../components/inputText.vue'
import InputNumber from '../components/inputNumber.vue'
import InputRadioButtons from '../components/inputRadioButtons'
import InputSelect2 from '../components/inputSelect2.vue'
import FieldConfirm from '../components/fieldConfirm.vue'

import show_flash_mixins from '../mixins/show_flash'

export default {
  components: {
    InputText,
    InputRadioButtons,
    InputSelect2,
    FieldConfirm
  },
  computed: {
    ...mapState({
      currentUser: state => state.user.currentUser,
      isValid: state => state.user.isValid
    })
  },
  data: function() {
    return {
      isRegistration: true,
      isConfirm: false,
      params: {}
    }
  },
  watch: {
    currentUser: function(val) {
      this.params = {
        id: val.id,
        birthday: val.birth_day,
        email: val.email,
        first_name: val.first_name,
        last_name: val.last_name,
        phone: val.phone,
        identity_card: val.identity_card
      }
    }
  },
  methods: {
    submitForm: async function() {
      await this.$store.dispatch('user/editUser', { params: this.params })
      this.isRegistration = true
      this.isConfirm = false

      this.show_flash(this.isValid)
    },
    submitConfirm: function() {
      this.isRegistration = false
      this.isConfirm = true
    },
    backToRegistration: function() {
      this.isConfirm = false
      this.isRegistration = true
    }
  },
  mixins: [show_flash_mixins]
}
</script>

<style>

</style>
