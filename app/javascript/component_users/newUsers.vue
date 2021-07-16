<template>
  <div class="new-users">
    <div class="d-flex">
      <div class="align-self-center">
        <h3>{{ $t('user.new_user') }}</h3>
      </div>
      <div class="d-flex ml-auto p-3">
        <UploadFile
          accept=".xlsm, .xlsx"
          action="user/importFile"
          :btn-title="$t('user.import_user')"
        />
        <div v-if="isRegisterNormal">
          <button
            class="btn btn-primary ml-3"
            @click="addNewUser"
          >
            {{ $t('user.add_user') }}
          </button>
        </div>
        <div v-else>
          <button
            class="btn btn-primary ml-3"
            @click="backToNormal"
          >
            {{ $t('user.back') }}
          </button>
        </div>
      </div>
    </div>
    <hr>
    <div v-if="isRegisterNormal">
      <form
        id="new-user"
        class="w-90 ml-auto mr-auto"
        @submit.prevent="submitForm"
      >
        <div
          v-for="(newUser, i) in newUsers"
          :key="i"
        >
          <div class="one-user">
            <div class="d-flex p-2">
              <h4 class="user-number">
                {{ $t('user.self') }} {{ i + 1 }}
              </h4>
              <button
                v-if="i > 0"
                class="btn btn-danger ml-auto"
                type="button"
                @click="deleteNewUser(i)"
              >
                {{ $t('user.delete_user') }}
              </button>
            </div>
            <div class="form-input p-2">
              <InputText
                v-model="newUser.first_name"
                :input-id="'first_name_' + i"
                :label-text="$t('user.first_name')"
                :value-input="newUser.first_name"
                :e-msg="errorMessages[i]? errorMessages[i]['first_name'] : ''"
                col-label="col-lg-1"
                col-input="col-lg-11"
              />
              <InputText
                v-model="newUser.last_name"
                :input-id="'last_name_' + i"
                :label-text="$t('user.last_name')"
                :value-input="newUser.last_name"
                :e-msg="errorMessages[i]? errorMessages[i]['last_name'] : ''"
                col-label="col-lg-1"
                col-input="col-lg-11"
              />
              <InputText
                v-model="newUser.email"
                :input-id="'email_' + i"
                :label-text="$t('user.email')"
                :value-input="newUser.email"
                :e-msg="errorMessages[i]? errorMessages[i]['email'] : ''"
                col-label="col-lg-1"
                col-input="col-lg-11"
              />
              <InputText
                v-model="newUser.phone"
                :input-id="'phone_' + i"
                :label-text="$t('user.phone')"
                :value-input="newUser.phone"
                :e-msg="errorMessages[i]? errorMessages[i]['phone'] : ''"
                col-label="col-lg-1"
                col-input="col-lg-11"
              />
              <InputText
                v-model="newUser.birthday"
                :input-id="'birthday_' + i"
                :label-text="$t('user.birthday')"
                :value-input="newUser.birthday"
                :e-msg="errorMessages[i]? errorMessages[i]['birthday'] : ''"
                col-label="col-lg-1"
                col-input="col-lg-11"
              />
              <InputText
                v-model="newUser.identity_card"
                :input-id="'identity_card_' + i"
                :label-text="$t('user.identity_card')"
                :value-input="newUser.identity_card"
                :e-msg="errorMessages[i]? errorMessages[i]['identity_card'] : ''"
                col-label="col-lg-1"
                col-input="col-lg-11"
              />
              <InputSelect2
                v-model="newUser.room_id"
                :input-id="'room_id_' + i"
                :label-text="$t('user.room_number')"
                :options="collectionRooms"
                :selected="newUser.holder_id"
                type-select="single_select"
                :place-holder="$t('user.select_room')"
                :e-msg="errorMessages[i]? errorMessages[i]['room_id'] : ''"
                col-label="col-lg-1"
                col-input="col-lg-11"
              />
              <InputImageFile
                :input-id="'avatar_' + i"
                :label-text="$t('user.avatar')"
                :e-msg="errorMessages[i]? errorMessages[i]['avatar'] : ''"
                :accept="'.jpg, .jpeg, .png'"
                col-label="col-lg-1"
                col-input="col-lg-11"
                @change="handleAvatar($event, i)"
              />
            </div>
          </div>
          <hr>
        </div>
        <button
          type="submit"
          class="btn btn-primary float-right mt-2"
        >
          {{ $t('user.submit') }}
        </button>
      </form>
    </div>
    <div v-else>
      <table class="table table-multi-body table-bordered">
        <thead class="table-header">
          <tr class="table-head">
            <td class="w-100px">
              {{ $t('user.no') }}
            </td>
            <td class="w-200px">
              {{ $t('user.first_name') }}
            </td>
            <td class="w-200px">
              {{ $t('user.last_name') }}
            </td>
            <td>{{ $t('user.email') }}</td>
            <td class="w-200px">
              {{ $t('user.phone') }}
            </td>
            <td class="w-120px">
              {{ $t('user.birthday') }}
            </td>
            <td class="w-200px">
              {{ $t('user.identity_card') }}
            </td>
            <td class="w-150px">
              {{ $t('user.room_number') }}
            </td>
            <td class="w-300px">
              {{ $t('user.errors') }}
            </td>
          </tr>
        </thead>
        <tbody
          v-for="(user, index) in importUsers"
          :key="index"
          :class="[(index % 2) != 0 ? 'odd-bg' : 'even-bg']"
        >
          <td>{{ index }}</td>
          <td>{{ user.first_name }}</td>
          <td>{{ user.last_name }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.phone }}</td>
          <td>{{ user.birthday }}</td>
          <td>{{ user.identity_card }}</td>
          <td>{{ user.room_number }}</td>
          <td class="break-line">
            {{ errorsImportUsers[index]? errorsImportUsers[index].join('\n') : $t('user.not_errors') }}
          </td>
        </tbody>
      </table>
      <button
        id="submit-import"
        type="submit"
        class="btn btn-primary float-right mt-2"
        @click="submitFormImport"
      >
        {{ $t('user.submit') }}
      </button>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputText from '../components/inputText.vue';
import InputSelect2 from '../components/inputSelect2.vue';
import UploadFile from '../components/uploadFile';
import InputImageFile from '../components/inputImageFile.vue';

export default {
  components: {
    InputText,
    InputSelect2,
    UploadFile,
    InputImageFile,
  },
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
      const formData = new FormData();
      this.newUsers.forEach(function(value, index) {
        Object.keys(value).forEach(function(key) {
          formData.append('multi_users[user_attributes]['+ index +']['+ key +']', value[key]);
        })
      });
      return formData;
    },
    backToNormal: function() {
      this.isRegisterNormal = true;
    },
    handleAvatar: function(e, index) {
      this.newUsers[index].avatar = e;
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
