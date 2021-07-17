<template>
  <div
    id="editUser"
    class="modal fade"
    role="dialog"
    aria-modal="true"
    aria-hidden="true"
    data-backdrop="static"
    tabindex="-1"
  >
    <div
      class="modal-dialog modal-dialog-centered modal-lg"
      role="document"
    >
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">
            Edit user <strong>{{ currentUser.full_name }}</strong>
          </h5>
        </div>
        <div
          v-if="currentUser.avatar"
          class="d-flex justify-content-center p-2"
        >
          <img
            :src="currentUser.avatar"
            class="img-thumbnail w-25"
          >
        </div>
        <div v-show="isRegistration">
          <div class="modal-body">
            <InputText
              v-model="params.first_name"
              input-id="first_name"
              :label-text="$t('user.first_name')"
              :value-input="params.first_name"
            />
            <InputText
              v-model="params.last_name"
              input-id="last_name"
              :label-text="$t('user.last_name')"
              :value-input="params.last_name"
            />
            <InputText
              v-model="params.email"
              input-id="email"
              :label-text="$t('user.email')"
              :value-input="params.email"
            />
            <InputText
              v-model="params.birthday"
              input-id="birthday"
              :label-text="$t('user.birthday')"
              :value-input="params.birthday"
            />
            <InputText
              v-model="params.phone"
              input-id="phone"
              :label-text="$t('user.phone')"
              :value-input="params.phone"
            />
            <InputText
              v-model="params.identity_card"
              :input-id="'identity_card'"
              :label-text="$t('user.identity_card')"
              :value-input="params.identity_card"
            />
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-dismiss="modal"
            >
              {{ $t('user.close') }}
            </button>
            <button
              type="button"
              class="btn btn-primary"
              @click="submitConfirm"
            >
              {{ $t('user.submit') }}
            </button>
          </div>
        </div>
        <div v-show="isConfirm">
          <div class="modal-body">
            <FieldConfirm
              :label-text="$t('user.first_name')"
              :value="params.first_name"
            />
            <FieldConfirm
              :label-text="$t('user.last_name')"
              :value="params.last_name"
            />
            <FieldConfirm
              :label-text="$t('user.email')"
              :value="params.email"
            />
            <FieldConfirm
              :label-text="$t('user.birthday')"
              :value="params.birthday"
            />
            <FieldConfirm
              :label-text="$t('user.phone')"
              :value="params.phone"
            />
            <FieldConfirm
              :label-text="$t('user.identity_card')"
              :value="params.identity_card"
            />
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              @click="backToRegistration"
            >
              {{ $t('user.back') }}
            </button>
            <button
              type="button"
              class="btn btn-primary"
              data-dismiss="modal"
              @click="submitForm"
            >
              {{ $t('user.save_change') }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputText from '../components/inputText.vue';
import InputNumber from '../components/inputNumber.vue';
import FieldConfirm from '../components/fieldConfirm.vue';
import show_flash_mixins from '../mixins/show_flash';

export default {
  components: {
    InputText,
    FieldConfirm,
  },
  mixins: [show_flash_mixins],
  data: function() {
    return {
      isRegistration: true,
      isConfirm: false,
      params: {},
    };
  },
  computed: {
    ...mapState({
      currentUser: (state) => state.user.currentUser,
      isValid: (state) => state.user.isValid,
    }),
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
        identity_card: val.identity_card,
      };
    },
  },
  methods: {
    submitForm: async function() {
      await this.$store.dispatch('user/editUser', {params: this.params});
      this.isRegistration = true;
      this.isConfirm = false;

      this.show_flash(this.isValid);
    },
    submitConfirm: function() {
      this.isRegistration = false;
      this.isConfirm = true;
    },
    backToRegistration: function() {
      this.isConfirm = false;
      this.isRegistration = true;
    },
  },
};
</script>
