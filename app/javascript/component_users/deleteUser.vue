<template>
  <div
    id="deleteUser"
    class="modal fade"
    role="dialog"
    aria-modal="true"
    aria-hidden="true"
    data-backdrop="static"
    data-keyboard="false"
  >
    <div
      class="modal-dialog modal-dialog-centered"
      role="document"
    >
      <div
        v-if="currentUser.status_active"
        class="modal-content"
      >
        <div class="modal-header">
          <h5 class="modal-title">
            {{ $t('user.delete_user') }} <strong>{{ currentUser.full_name }}</strong>
          </h5>
        </div>
        <div class="modal-body">
          <span>
            {{ $t('user.confirmation.perform_delete_user') }} 
            <span class="text-danger">{{ currentUser.full_name }}</span>?
          </span>
          <hr>
          <InputToggleSwitch
            v-model="confirm"
            :label-text="$t('user.confirmation.yes')"
            input-id="confirm"
            @checked="confirm = $event"
          />
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-dismiss="modal"
          >
            {{ $t('user.confirmation.close') }}
          </button>
          <button
            type="button"
            class="btn btn-danger btn-delete"
            data-dismiss="modal"
            @click="submitDelete"
          >
            {{ $t('user.delete') }}
          </button>
        </div>
      </div>
      <div
        v-else
        class="modal-content"
      >
        <div class="modal-header">
          <h5 class="modal-title">
            {{ $t('user.info') }}
          </h5>
        </div>
        <div class="modal-body">
          <span>
            {{ $t('user.self') }} 
            <strong class="text-danger">
              {{ currentUser.full_name }}
            </strong> 
            {{ $t('user.deleted') }}
          </span>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-dismiss="modal"
          >
            {{ $t('user.confirmation.close') }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import InputToggleSwitch from '../components/inputToggleSwitch';

export default {
  components: {
    InputToggleSwitch,
  },
  data: function() {
    return {
      params: {},
      confirm: false,
    };
  },
  computed: {
    ...mapState({
      currentUser: (state) => state.user.currentUser,
    }),
  },
  watch: {
    currentUser: function(val) {
      this.confirm = false;
      this.params = {
        id: val.id,
      };
    },
  },
  updated: function() {
    $('.btn-delete').prop('disabled', !this.confirm);
  },
  methods: {
    submitDelete: function() {
      if (!this.confirm) return;
      this.$store.dispatch('user/deleteUser', {params: this.params});
    },
  },
};
</script>
