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
      class="collapse"
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
                v-model="room_number_cont"
                class="form-control"
                type="text"
                :placeholder="$t('invoice.placeholder_search')"
              >
            </div>
            <div class="col-1">
              <button
                type="submit"
                class="btn btn-light"
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
                  v-for="(month, key) in months"
                  :key="key"
                  type="button"
                  class="btn btn-light"
                >
                  {{ month }}
                </button>
              </div>
            </div>
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
      months: this.$t('invoice.month_names'),
      room_number_cont: '',
    }
  },
  computed: {
    ...mapState(['params']),
  },
  methods: {
    ...mapActions(['submitFormSearch']),
  }
}
</script>
