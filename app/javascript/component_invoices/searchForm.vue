<template>
  <div class="card mb-5">
    <div
      class="card-header p-0"
      data-toggle="collapse"
      data-target="#collapseFormSearch"
    >
      <button
        class="btn dropdown-toggle"
        type="button"
      >
        <i class="fas fa-search" />
        <span class="font-weight-bold">{{ $t('invoice.search') }}</span>
      </button>
    </div>
    <div
      id="collapseFormSearch"
      class="collapse show"
    >
      <div class="card-body">
        <form
          id="search-invoices"
          @submit.prevent="submitForm"
        >
          <div class="form-group row">
            <label
              for="roomNumber"
              class="col-2 col-form-label text-right"
            >{{ $t('invoice.room_number') }}</label>
            <div class="col-3">
              <input
                id="roomNumber"
                v-model="roomNumber"
                class="form-control"
                type="text"
                :placeholder="$t('invoice.placeholder_search')"
              >
            </div>
            <div class="col-1">
              <button
                type="submit"
                class="btn btn-light text-nowrap"
              >
                {{ $t('invoice.search') }}
              </button>
            </div>
          </div>
          <div
            v-if="true"
            class="form-group row"
          >
            <label class="col-2 col-form-label text-right">
              {{ $t('invoice.filter') }}
              |
              {{ $t('invoice.month') }}
            </label>
            <div class="col-8">
              <div
                class="btn-group flex-wrap"
                role="group"
              >
                <button
                  v-for="(month, index) in resultMonths"
                  :key="index"
                  :ref="`button_${month}`"
                  type="button"
                  :class="['btn btn-light', dateExport == month ? 'active' : '']"
                  @click="setMonth(month)"
                >
                  {{ $t('invoice.month_names')[month] }}
                </button>
              </div>
            </div>
          </div>
          <div class="row m-0 justify-content-end">
            <button
              class="btn btn-secondary text-nowrap"
              @click="resetForm"
            >
              {{ $t('invoice.reset') }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import {createNamespacedHelpers} from 'vuex';
const {mapState, mapActions} = createNamespacedHelpers('invoice');

export default {
  data() {
    return {
      roomNumber: '',
      dateExport: '',
    }
  },
  computed: {
    ...mapState(['params', 'resultMonths']),
  },
  mounted() {
    this.roomNumber = this.params.room_number;
    this.dateExport = this.params.date_export;
  },
  methods: {
    ...mapActions(['submitFormSearch']),
    setMonth(month) {
      for (const [_btn, element] of Object.entries(this.$refs)) {
        element[0].classList.remove('active');
      }

      const button = this.$refs[`button_${month}`][0];
      if (this.dateExport !== month) {
        button.classList.add('active');
        this.dateExport = month;
      } else {
        button.blur();
        this.dateExport = '';
      }

      this.submitForm();
    },
    submitForm() {
      const page = 1;
      const params = {};
      params['room_number'] = this.roomNumber;
      params['date_export'] = this.dateExport;

      this.submitFormSearch({ params, page });
    },
    resetForm() {
      this.roomNumber = '';
      this.dateExport = '';

      this.submitForm();
    },
  }
}
</script>
