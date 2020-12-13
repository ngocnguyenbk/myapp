<template>
  <div class="new-users">
    <div  class="d-flex">
      <div class="align-self-center">
        <h3>New user</h3>
      </div>
      <div class="d-flex ml-auto p-3">
        <button class="btn btn-primary" @click="addNewUser">Add user</button>
      </div>
    </div>
    <hr/>
    <form id="new-user" class="w-90 ml-auto mr-auto" @submit.prevent="submitForm">
      <div v-for="(newUser, i) in newUsers" :key="i">
        <div class="one-user">
          <div class="d-flex p-2">
            <h4 class="user-number">User {{i + 1}}</h4>
            <button class="btn btn-danger ml-auto" type="button" @click="deleteNewUser(i)" v-if="i > 0">Delete</button>
          </div>
          <div class="form-input p-2">
            <InputText :inputId="'first_name_' + i" labelText="First name"
                       v-model="newUser.first_name"
                       :valueInput="newUser.first_name"
                       :eMsg="errorMessages[i]? errorMessages[i]['first_name'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'last_name_' + i" labelText="Last name"
                       v-model="newUser.last_name"
                       :valueInput="newUser.last_name"
                       :eMsg="errorMessages[i]? errorMessages[i]['last_name'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'email_' + i" labelText="Email"
                       v-model="newUser.email"
                       :valueInput="newUser.email"
                       :eMsg="errorMessages[i]? errorMessages[i]['email'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'phone_' + i" labelText="Phone"
                       v-model="newUser.phone"
                       :valueInput="newUser.phone"
                       :eMsg="errorMessages[i]? errorMessages[i]['phone'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'birthday_' + i" labelText="Birthday"
                       v-model="newUser.birthday"
                       :valueInput="newUser.birthday"
                       :eMsg="errorMessages[i]? errorMessages[i]['birthday'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'identity_card_' + i" labelText="Identity card"
                       v-model="newUser.identity_card"
                       :valueInput="newUser.identity_card"
                       :eMsg="errorMessages[i]? errorMessages[i]['identity_card'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputSelect2 :inputId="'room_id_' + i" labelText="Room number"
              :options="collectionRooms"
              :selected="newUser.holder_id"
              typeSelect="single_select"
              v-model="newUser.room_id"
              placeHolder="Select room"
              :eMsg="errorMessages[i]? errorMessages[i]['room_id'] : ''"
              colLable="col-lg-1" colInput="col-lg-11"
            />
          </div>
          <hr/>
        </div>
      </div>
      <button type="submit" class="btn btn-primary float-right mt-2">Submit</button>
    </form>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import InputText from '../components/inputText.vue'
import InputNumber from '../components/inputNumber.vue'
import InputRadioButtons from '../components/inputRadioButtons'
import InputSelect2 from '../components/inputSelect2.vue'
import FieldConfirm from '../components/fieldConfirm.vue'
export default {
  data: function() {
    return {
      params: {}
    }
  },
  computed: {
    ...mapState({
      collectionRooms: state => state.user.rooms,
      newUsers: state => state.user.newUsers,
      errorMessages: state => state.user.errorMessages
    })
  },
  components: {
    InputText,
    InputNumber,
    InputRadioButtons,
    InputSelect2,
    FieldConfirm
  },
  methods: {
    submitForm: function() {
      this.$store.dispatch('user/createUsers', { params: this.handleParams() })
    },
    addNewUser: function() {
      this.$store.dispatch('user/setNewUser')
    },
    deleteNewUser: function(index) {
      this.$store.dispatch('user/deleteNewUser', index)
    },
    handleParams: function() {
      let self = this
      this.newUsers.forEach(function (value, index) {
        self.params[index] = value
      })
      return self.params
    }
  }
}
</script>

<style lang="scss" scoped>
.form-input {
  border: 2px solid #e8e7e7;
  background-color: #f3f3f3;
}
</style>
