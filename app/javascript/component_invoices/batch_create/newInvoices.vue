<template>
  <form
    id="new-invoices"
    @submit.prevent="checkForm"
  >
    <button
      v-if="isValid"
      class="btn btn-primary float-right mb-2"
    >
      {{ $t('invoice.submit_form') }}
    </button>
    <button
      v-else
      class="btn btn-primary float-right mb-2"
    >
      {{ $t('invoice.check_form') }}
    </button>
    <InputDate
      v-model="month"
      input-id="month-invoice"
      :label-text="$t('invoice.month')"
      :language="$i18n.locale"
      :date-format="'MM/yyyy'"
      :minimum-view="'month'"
      :maximum-view="'year'"
      :value-input="month"
      col-label="mr-3"
      col-input="form-inline text-center"
    />
    <table class="table table-multi-body table-bordered">
      <thead class="table-header">
        <tr class="table-head text-center">
          <td
            rowspan="2"
            class="w-70px check-all"
          >
            <div class="form-check">
              <input
                id="check-all"
                v-model="checkAll"
                type="checkbox"
                class="form-check-input"
              >
              <label
                class="form-check-label"
                for="check-all"
              />
            </div>
          </td>
          <th rowspan="2">
            {{ $t('invoice.room') }}
          </th>
          <th rowspan="2">
            {{ $t('invoice.deposited') }}
          </th>
          <th
            rowspan="2"
            class="w-100px"
          >
            {{ $t('invoice.price') }}
          </th>
          <th rowspan="2">
            {{ $t('invoice.day_used_per_month') }}
          </th>
          <th colspan="4">
            {{ $t('invoice.electric') }}
          </th>
          <th colspan="4">
            {{ $t('invoice.water') }}
          </th>
          <th rowspan="2">
            {{ $t('invoice.internet') }}
          </th>
          <th rowspan="2">
            {{ $t('invoice.unit_price_parking_fee') }}
          </th>
          <th rowspan="2">
            {{ $t('invoice.num') }}
          </th>
          <th rowspan="2">
            {{ $t('invoice.service') }}
          </th>
          <th
            rowspan="2"
            class="w-180px"
          >
            {{ $t('invoice.total') }}
          </th>
          <th rowspan="2">
            {{ $t('invoice.reduce') }}
          </th>
          <th
            rowspan="2"
            class="w-160px"
          >
            {{ $t('invoice.holder') }}
          </th>
          <th
            rowspan="2"
            class="w-180px"
          >
            {{ $t('invoice.note') }}
          </th>
        </tr>
        <tr>
          <th class="w-70px">
            {{ $t('invoice.begin_number') }}
          </th>
          <th class="w-70px">
            {{ $t('invoice.end_number') }}
          </th>
          <th>{{ $t('invoice.use') }}</th>
          <th class="w-75px">
            {{ $t('invoice.into_money') }}
          </th>
          <th class="w-70px">
            {{ $t('invoice.begin_number') }}
          </th>
          <th class="w-70px">
            {{ $t('invoice.end_number') }}
          </th>
          <th>{{ $t('invoice.use') }}</th>
          <th class="w-75px">
            {{ $t('invoice.into_money') }}
          </th>
        </tr>
      </thead>
      <RowInvoiceForm
        v-for="(item, room_number) in invoicesForm"
        :key="room_number"
        :item="item"
        :room-name="room_number"
        :month="month"
        :check-all="checkAll"
        @checked="handleCheck($event)"
        @input="handleInput()"
      />
    </table>
    <button
      v-if="isValid"
      class="btn btn-primary float-right mb-2"
    >
      {{ $t('invoice.submit_form') }}
    </button>
    <button
      v-else
      class="btn btn-primary float-right mb-2"
    >
      {{ $t('invoice.check_form') }}
    </button>
  </form>
</template>

<script>
import {mapState} from 'vuex';
import show_flash_mixins from '../../mixins/show_flash';
import {some, forEach} from 'lodash';

import RowInvoiceForm from './rowInvoiceForm';
import InputDate from '../../components/inputDate';

export default {
  components: {
    RowInvoiceForm,
    InputDate,
  },
  mixins: [show_flash_mixins],
  data: function() {
    return {
      flashMsg: '',
      isValid: false,
      month: new Date(),
      checkAll: false,
      listChecked: {},
    };
  },
  computed: {
    ...mapState({
      invoicesForm: (state) => state.invoice.invoicesForm,
      inputForm: (state) => state.invoice.inputForm,
      flashStateMsg: (state) => state.invoice.flashMsg,
    }),
  },
  watch: {
    listChecked(_val) {
      this.isValid = false;
    },
    month(_val) {
      this.isValid = false;
      this.$store.dispatch('invoice/getInvoiceForm',
        {month: `${this.month.getMonth() + 1}/${this.month.getFullYear()}`}
      );
    },
    checkAll(_val) {
      this.isValid = false;
    },
  },
  created: function() {
    this.$store.dispatch('invoice/getInvoiceForm', {month: `${this.month.getMonth() + 1}/${this.month.getFullYear()}`});
  },
  methods: {
    checkForm: function() {
      if (this.isValid) {
        this.submitForm();
      } else {
        this.validForm();
      }
    },
    validForm: function() {
      const self = this;
      if (this.month === '') {
        this.flashMsg = this.$t('invoice.input_month');
        this.show_flash(false);

        return;
      } else if (some(this.listChecked, (val) => {
        return val;
      })) {
        this.isValid = true;
      } else {
        this.flashMsg = this.$t('invoice.choose_room');
        this.show_flash(false);

        return;
      }

      forEach(this.inputForm, function(item, roomNumber) {
        if (!self.listChecked[roomNumber]) return;

        const validEle = item.electric.end_number >= item.electric.begin_number;
        const validWat = item.water.end_number >= item.water.begin_number;
        self.isValid = item.electric.total >= 0 && item.water.total >= 0 &&
                      item.invoice.total >= 0 && validEle && validWat;
        if (!self.isValid) {
          self.flashMsg = self.$t('invoice.error_msg', {room: roomNumber});
          return false;
        }
      });

      if (this.isValid) {
        this.flashMsg = this.$t('invoice.success_msg');
        this.show_flash(true);
      } else {
        this.show_flash(false);
      }
    },
    submitForm: async function() {
      const self = this;
      const submitForm = {};
      if (!this.isValid) return;

      forEach(this.inputForm, function(item, roomNumber) {
        if (!self.listChecked[roomNumber]) return;

        submitForm[roomNumber] = item;
      });

      await this.$store.dispatch('invoice/createInvoices', {params: submitForm, month: this.month});
      if (!self.flashStateMsg) return;

      self.flashMsg = self.flashStateMsg;
      self.show_flash(false);
    },
    handleCheck(event) {
      this.listChecked[event.roomNumber] = event.check;
    },
    handleInput() {
      this.isValid = false;
    },
  },
};
</script>
