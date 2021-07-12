<template>
  <div class="new-users">
    <div  class="d-flex">
      <div class="align-self-center">
        <h3>{{ $t('user.new_user') }}</h3>
      </div>
      <div class="d-flex ml-auto p-3">
        <UploadFile
          accept=".xlsm, .xlsx"
          action="user/importFile"
          :btnTitle="$t('user.import_user')"
        />
        <div v-if="isRegisterNormal">
          <button class="btn btn-primary ml-3" @click="addNewUser">{{ $t('user.add_user') }}</button>
        </div>
        <div v-else>
          <button class="btn btn-primary ml-3" @click="backToNormal">{{ $t('user.back') }}</button>
        </div>
      </div>
    </div>
    <hr/>
    <div v-if="isRegisterNormal">
      <form id="new-user" class="w-90 ml-auto mr-auto" @submit.prevent="submitForm">
        <div v-for="(newUser, i) in newUsers" :key="i">
          <div class="one-user">
            <div class="d-flex p-2">
              <h4 class="user-number">{{ $t('user.self') }} {{i + 1}}</h4>
              <button class="btn btn-danger ml-auto" type="button" @click="deleteNewUser(i)" v-if="i > 0">{{ $t('user.delete_user') }}</button>
            </div>
            <div class="form-input p-2">
              <InputText :inputId="'first_name_' + i" :labelText="$t('user.first_name')"
                        v-model="newUser.first_name"
                        :valueInput="newUser.first_name"
                        :eMsg="errorMessages[i]? errorMessages[i]['first_name'] : ''"
                        colLabel="col-lg-1" colInput="col-lg-11"
              />
              <InputText :inputId="'last_name_' + i" :labelText="$t('user.last_name')"
                        v-model="newUser.last_name"
                        :valueInput="newUser.last_name"
                        :eMsg="errorMessages[i]? errorMessages[i]['last_name'] : ''"
                        colLabel="col-lg-1" colInput="col-lg-11"
              />
              <InputText :inputId="'email_' + i" :labelText="$t('user.email')"
                        v-model="newUser.email"
                        :valueInput="newUser.email"
                        :eMsg="errorMessages[i]? errorMessages[i]['email'] : ''"
                        colLabel="col-lg-1" colInput="col-lg-11"
              />
              <InputText :inputId="'phone_' + i" :labelText="$t('user.phone')"
                        v-model="newUser.phone"
                        :valueInput="newUser.phone"
                        :eMsg="errorMessages[i]? errorMessages[i]['phone'] : ''"
                        colLabel="col-lg-1" colInput="col-lg-11"
              />
              <InputText :inputId="'birthday_' + i" :labelText="$t('user.birthday')"
                        v-model="newUser.birthday"
                        :valueInput="newUser.birthday"
                        :eMsg="errorMessages[i]? errorMessages[i]['birthday'] : ''"
                        colLabel="col-lg-1" colInput="col-lg-11"
              />
              <InputText :inputId="'identity_card_' + i" :labelText="$t('user.identity_card')"
                        v-model="newUser.identity_card"
                        :valueInput="newUser.identity_card"
                        :eMsg="errorMessages[i]? errorMessages[i]['identity_card'] : ''"
                        colLabel="col-lg-1" colInput="col-lg-11"
              />
              <InputSelect2 :inputId="'room_id_' + i" :labelText="$t('user.room_number')"
                :options="collectionRooms"
                :selected="newUser.holder_id"
                typeSelect="single_select"
                v-model="newUser.room_id"
                :placeHolder="$t('user.select_room')"
                :eMsg="errorMessages[i]? errorMessages[i]['room_id'] : ''"
                colLabel="col-lg-1" colInput="col-lg-11"
              />
            </div>
          </div>
          <hr/>
        </div>
        <button type="submit" class="btn btn-primary float-right mt-2">{{ $t('user.submit') }}</button>
      </form>
    </div>
    <div v-else>
      <table class="table table-multi-body table-bordered">
        <thead class="table-header">
          <tr class="table-head">
            <td class="w-100px">{{ $t('user.no') }}</td>
            <td class="w-200px">{{ $t('user.first_name') }}</td>
            <td class="w-200px">{{ $t('user.last_name') }}</td>
            <td>{{ $t('user.email') }}</td>
            <td class="w-200px">{{ $t('user.phone') }}</td>
            <td class="w-120px">{{ $t('user.birthday') }}</td>
            <td class="w-200px">{{ $t('user.identity_card') }}</td>
            <td class="w-150px">{{ $t('user.room_number') }}</td>
            <td class="w-300px">{{ $t('user.errors') }}</td>
          </tr>
        </thead>
        <tbody :class="[(index % 2) != 0 ? 'odd-bg' : 'even-bg']" v-for="(user, index) in importUsers" :key="index">
          <td>{{ index }}</td>
          <td>{{ user.first_name }}</td>
          <td>{{ user.last_name }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.phone }}</td>
          <td>{{ user.birthday }}</td>
          <td>{{ user.identity_card }}</td>
          <td>{{ user.room_number }}</td>
          <td class="break-line">{{ errorsImportUsers[index]? errorsImportUsers[index].join('\n') : $t('user.not_errors') }}</td>
        </tbody>
      </table>
      <button type="submit" id="submit-import" class="btn btn-primary float-right mt-2" @click="submitFormImport">{{ $t('user.submit') }}</button>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputText from '../components/inputText.vue';
import InputNumber from '../components/inputNumber.vue';
import InputRadioButtons from '../components/inputRadioButtons';
import InputSelect2 from '../components/inputSelect2.vue';
import FieldConfirm from '../components/fieldConfirm.vue';
import UploadFile from '../components/uploadFile';

export default {
  data: function() {
    return {
      params: {},
      isRegisterNormal: true,
    };
  },
  computed: {
    ...mapState({
      collectionRooms: (state) => state.user.rooms,
      newUsers: (state) => state.user.newUsers,
      errorMessages: (state) => state.user.errorMessages,
      importUsers: (state) => state.user.importUsers,
      errorsImportUsers: (state) => state.user.errorsImportUsers,
    }),
  },
  components: {
    InputText,
    InputNumber,
    InputRadioButtons,
    InputSelect2,
    FieldConfirm,
    UploadFile,
  },
  methods: {
    submitForm: function() {
      this.$store.dispatch('user/createUsers', {params: this.handleParams()});
    },
    submitFormImport: function() {
      if (Object.keys(this.errorsImportUsers).length != 0) return;

      const users = this.importUsers;
      Object.values(users).forEach(function(user) {
        delete user.room_number;
      });

      this.$store.dispatch('user/importFile', {users: {import_users: users, step: 'done'}});
    },
    addNewUser: function() {
      this.$store.dispatch('user/setNewUser');
    },
    deleteNewUser: function(index) {
      this.$store.dispatch('user/deleteNewUser', index);
    },
    handleParams: function() {
      const self = this;
      this.newUsers.forEach(function(value, index) {
        self.params[index] = value;
      });
      return self.params;
    },
    backToNormal: function() {
      this.isRegisterNormal = true;
    },
  },
  watch: {
    importUsers: function(val) {
      this.isRegisterNormal = false;
    },
  },
  updated: function() {
    if (Object.keys(this.errorsImportUsers).length == 0) {
      $('#submit-import').prop('disabled', false);
    } else {
      $('#submit-import').prop('disabled', true);
    }
  },
};
</script>

<style lang="scss" scoped>
.form-input {
  border: 2px solid #e8e7e7;
  background-color: #f3f3f3;
}
.break-line {
  white-space: pre;
}
</style>
