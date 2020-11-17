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
            <InputText :inputId="'first_name_' + i" lableText="First name"
                       v-model="newUser.first_name"
                       :valueInput="newUser.first_name"
                       :eMsg="errorMessases[i]? errorMessases[i]['first_name'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'last_name_' + i" lableText="Last name"
                       v-model="newUser.last_name"
                       :valueInput="newUser.last_name"
                       :eMsg="errorMessases[i]? errorMessases[i]['last_name'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'email_' + i" lableText="Email"
                       v-model="newUser.email"
                       :valueInput="newUser.email"
                       :eMsg="errorMessases[i]? errorMessases[i]['email'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'phone_' + i" lableText="Phone"
                       v-model="newUser.phone"
                       :valueInput="newUser.phone"
                       :eMsg="errorMessases[i]? errorMessases[i]['phone'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'birthday_' + i" lableText="Birthday"
                       v-model="newUser.birthday"
                       :valueInput="newUser.birthday"
                       :eMsg="errorMessases[i]? errorMessases[i]['birthday'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputText :inputId="'identity_card_' + i" lableText="Identity card"
                       v-model="newUser.identity_card"
                       :valueInput="newUser.identity_card"
                       :eMsg="errorMessases[i]? errorMessases[i]['identity_card'] : ''"
                       colLable="col-lg-1" colInput="col-lg-11"
            />
            <InputSelect2 :inputId="'room_id_' + i" lableText="Room number"
              :options="collectionRooms"
              :selected="newUser.holder_id"
              typeSelect="single_select"
              v-model="newUser.room_id"
              placeHolder="Select room"
              :eMsg="errorMessases[i]? errorMessases[i]['room_id'] : ''"
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
      errorMessases: state => state.user.errorMessases
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
