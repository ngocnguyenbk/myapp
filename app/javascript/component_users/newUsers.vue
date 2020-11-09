<template>
  <div class="new-users">
    <div  class="d-flex">
      <h1>New User</h1>
      <div class="d-flex ml-auto p-3">
        <button class="btn btn-primary" @click="addNewUser">Add user</button>
      </div>
    </div>
    <hr/>
    <form id="new-user" class="w-90 ml-auto mr-auto" @submit="submitForm">
      <div v-for="(newUser, i) in newUsers" :key="i">
        <div class="one-user">
          <div class="d-flex p-2">
            <h4 class="user-number">User {{i + 1}}</h4>
            <button class="btn btn-danger ml-auto" type="button" @click="deleteNewUser(i)" v-if="i > 0">Delete</button>
          </div>
          <div class="form-input p-2">
            <InputText :inputId="'first_name_' + i" lableText="First name" v-model="newUser.first_name" :valueInput="newUser.first_name"/>
            <InputText :inputId="'last_name_' + i" lableText="Last name" v-model="newUser.last_name" :valueInput="newUser.last_name"/>
            <InputText :inputId="'email_' + i" lableText="Email" v-model="newUser.email" :valueInput="newUser.email"/>
            <InputText :inputId="'phone_' + i" lableText="Phone" v-model="newUser.phone" :valueInput="newUser.phone"/>
            <InputText :inputId="'birthday_' + i" lableText="Birthday" v-model="newUser.birthday" :valueInput="newUser.birthday"/>
            <InputText :inputId="'identity_card_' + i" lableText="Identity card" v-model="newUser.identity_card" :valueInput="newUser.identity_card"/>
            <InputSelect2 :inputId="'room_id_' + i" lableText="Room number"
              :options="collectionRooms"
              :selected="newUser.holder_id"
              typeSelect="single_select"
              v-model="newUser.room_id"
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
  computed: {
    ...mapState({
      collectionRooms: state => state.user.rooms,
      newUsers: state => state.user.newUsers
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
      debugger
    },
    addNewUser: function() {
      this.$store.dispatch('user/setNewUser')
    },
    deleteNewUser: function(index) {
      this.$store.dispatch('user/deleteNewUser', index)
    }
  }
}
</script>

<style>

.form-input{
  border: 1px solid #bab7b7;
}

</style>
