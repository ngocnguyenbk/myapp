<template>
  <tbody :class="background_row">
    <tr
      v-if="is_empty"
      class="table-head text-center"
    >
      <td>
        <div class="form-check">
          <input
            type="checkbox"
            class="form-check-input"
            disabled
          >
          <label class="form-check-label" />
        </div>
      </td>
      <td>{{ roomName }}</td>
      <td
        v-for="index in sameCell"
        :key="index"
      />
      <td>{{ $t('invoice.not_contract') }}</td>
    </tr>

    <tr
      v-else
      class="table-head text-center js-input"
    >
      <td>
        <div class="form-check">
          <input
            :id="`check-${roomName}`"
            v-model="checked"
            type="checkbox"
            class="form-check-input"
          >
          <label
            class="form-check-label"
            :for="`check-${roomName}`"
          />
        </div>
      </td>
      <td>
        <input
          :id="roomName"
          v-model="roomNumber"
          readonly
        >
      </td>
      <td>
        <input
          :id="`deposited_money_${roomName}`"
          readonly
          :value="depMoney.toLocaleString()"
        >
      </td>
      <td>
        <input
          :id="`room_price_${roomName}`"
          readonly
          :value="roomPrice.toLocaleString()"
        >
      </td>
      <td>
        <input
          :id="`day_used_per_month_${roomName}`"
          v-model="dayUsedPerMonth"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`electric_begin_number_${roomName}`"
          v-model="eleBegin"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`electric_end_number_${roomName}`"
          v-model="eleEnd"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`electric_quantity_${roomName}`"
          readonly
          :value="eleQty.toLocaleString()"
        >
      </td>
      <td>
        <input
          :id="`electric_total_${roomName}`"
          readonly
          :value="eleTotal.toLocaleString()"
        >
      </td>
      <td>
        <input
          :id="`water_begin_number_${roomName}`"
          v-model="watBegin"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`water_end_number_${roomName}`"
          v-model="watEnd"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`water_quantity_${roomName}`"
          readonly
          :value="watQty.toLocaleString()"
        >
      </td>
      <td>
        <input
          :id="`water_total_${roomName}`"
          readonly
          :value="watTotal.toLocaleString()"
        >
      </td>
      <td>
        <input
          :id="`internet_unit_${roomName}`"
          v-model="intUnit"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`parking_fee_unit_${roomName}`"
          v-model="pafUnit"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`parking_fee_quantity_${roomName}`"
          v-model="pafQty"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`service_unit_${roomName}`"
          v-model="serUnit"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>
        <input
          :id="`total_${roomName}`"
          readonly
          :value="total.toLocaleString()"
        >
      </td>
      <td>
        <input
          :id="`reduce_${roomName}`"
          v-model="invReduce"
          type="text"
          pattern="[0-9]+"
          class="input_border"
        >
      </td>
      <td>{{ item.extend_data.holder_name }}</td>
      <td />
    </tr>
  </tbody>
</template>

<script>
export default {
  props: {
    item: {
      type: Object,
      required: true,
    },
    roomName: {
      type: String,
      required: true,
    },
    month: {
      type: Date,
      default: new Date(),
    },
    checkAll: {
      type: Boolean,
      required: true,
    },
  },
  data: function() {
    if (Object.keys(this.item).length == 0) {
      return {
        sameCell: 17,
      };
    } else {
      return {
        roomNumber: this.roomName,
        depMoney: this.item.contract.deposited_money,
        roomPrice: this.item.contract.room_price,
        eleBegin: this.item.electric.begin_number,
        eleEnd: this.item.electric.end_number,
        watBegin: this.item.water.begin_number,
        watEnd: this.item.water.end_number,
        intUnit: this.item.internet.unit_price,
        pafUnit: this.item.parking_fee.unit_price,
        pafQty: this.item.parking_fee.quantity,
        serUnit: this.item.service.unit_price,
        invReduce: this.item.invoice.reduce,
        dayUsedPerMonth: this.item.invoice.day_used_per_month,
        checked: false,
      };
    }
  },
  computed: {
    background_row: function() {
      return this.is_empty ? 'odd-bg' : 'even-bg';
    },
    is_empty: function() {
      return Object.keys(this.item).length == 0;
    },
    eleQty: function() {
      return (this.eleEnd > this.eleBegin) ? (this.eleEnd - this.eleBegin) : 0;
    },
    eleTotal: function() {
      return this.eleQty * this.item.electric.unit_price;
    },
    watQty: function() {
      return (this.watEnd > this.watBegin) ? (this.watEnd - this.watBegin) : 0;
    },
    watTotal: function() {
      return this.watQty * this.item.water.unit_price;
    },
    totalDayInMonth: function() {
      return new Date(new Date(this.month).getFullYear(), new Date(this.month).getMonth() + 1, 0).getDate();
    },
    intTotal: function() {
      return this.intUnit * this.dayUsedPerMonth / this.totalDayInMonth;
    },
    pafTotal: function() {
      return this.pafQty * this.pafUnit * this.dayUsedPerMonth / this.totalDayInMonth;
    },
    serTotal: function() {
      return this.serUnit * this.dayUsedPerMonth / this.totalDayInMonth;
    },
    roomPriceTotal: function() {
      return this.roomPrice * this.dayUsedPerMonth / this.totalDayInMonth;
    },
    total: function() {
      return Math.floor(this.roomPriceTotal
        + this.eleTotal
        + this.watTotal
        + this.intTotal
        + this.pafTotal
        + this.serTotal
        - this.invReduce);
    },
  },
  watch: {
    item: function(val) {
      if (JSON.stringify(val) === JSON.stringify({})) return;

      this.depMoney = val.contract.deposited_money;
      this.roomPrice = val.contract.room_price;
      this.eleBegin = val.electric.begin_number;
      this.eleEnd = val.electric.end_number;
      this.watBegin = val.water.begin_number;
      this.watEnd = val.water.end_number;
      this.intUnit = val.internet.unit_price;
      this.pafUnit = val.parking_fee.unit_price;
      this.pafQty = val.parking_fee.quantity;
      this.serUnit = val.service.unit_price;
      this.invReduce = val.invoice.reduce;
      this.dayUsedPerMonth = val.invoice.day_used_per_month;
    },
    eleBegin: function(_val) {
      this.buildForm();
    },
    eleEnd: function(_val) {
      this.buildForm();
    },
    watBegin: function(_val) {
      this.buildForm();
    },
    watEnd: function(_val) {
      this.buildForm();
    },
    dayUsedPerMonth: function(_val) {
      this.buildForm();
    },
    pafQty: function(_val) {
      this.buildForm();
    },
    pafUnit: function(_val) {
      this.buildForm();
    },
    roomPrice: function(_val) {
      this.buildForm();
    },
    intUnit: function(_val) {
      this.buildForm();
    },
    serUnit: function(_val) {
      this.buildForm();
    },
    invReduce: function(_val) {
      this.buildForm();
    },
    checkAll(val) {
      this.checked = val;
    },
    checked(val) {
      this.$emit('checked', {check: val, roomNumber: this.roomNumber});
    },
  },
  mounted: function() {
    if (!this.is_empty) {
      this.buildForm();
    }
    const self = this;
    $('.js-input').find(':input').on('click', function(e) {
      $(this).select();
    });

    $('.js-input').find(':input').on('keyup', function(e) {
      const arrow = {left: 37, up: 38, right: 39, down: 40};
      if ($.inArray(e.keyCode, [arrow.left, arrow.up, arrow.right, arrow.down]) < 0) return;

      const td = $(this).closest('td');
      let moveTo = null;
      switch (e.keyCode) {
        case arrow.left:
          moveTo = td.prev('td');
          break;
        case arrow.right:
          moveTo = td.next('td');
          break;
        case arrow.up:
        case arrow.down:
          const tBody = td.closest('tbody');
          const pos = td[0].cellIndex;
          let moveToRow = null;

          if (e.keyCode == arrow.down) {
            moveToRow = self.findClosestTr(tBody, 'down');
          } else if (e.keyCode == arrow.up) {
            moveToRow = self.findClosestTr(tBody, 'up');
          }
          if (typeof moveToRow === 'undefined') return;
          if (moveToRow.length) {
            moveTo = $(moveToRow[0].cells[pos]);
          }
          break;
      }

      if (moveTo && moveTo.length) {
        e.preventDefault();
        moveTo.find('input').each(function(i, input) {
          input.focus();
          input.select();
        });
      }
    });

    $('.js-input').find(':input').on('input', (e) => {
      this.$emit('input');
    });
  },
  methods: {
    findClosestTr: function(tBody, arrow) {
      let rowContinue = null;
      if (arrow === 'up') {
        rowContinue = tBody.prev('tbody');
      } else if (arrow === 'down') {
        rowContinue = tBody.next('tbody');
      }
      if (rowContinue.length == 0) return;
      if (rowContinue.find('input').length <= 1) {
        return this.findClosestTr(rowContinue, arrow);
      } else {
        return rowContinue.find('tr');
      }
    },
    isNumeric: function(val) {
      return !isNaN(parseFloat(val)) && isFinite(val);
    },
    buildForm: function() {
      const form = {
        invoice: {
          date_export: this.month,
          reduce: this.invReduce,
          total: this.total,
          contract_id: this.item.contract.contract_id,
          day_used_per_month: this.dayUsedPerMonth,
          room_id: this.item.contract.room_id,
        },
        electric: {
          begin_number: this.eleBegin,
          end_number: this.eleEnd,
          quantity: this.eleQty,
          total: this.eleTotal,
        },
        water: {
          begin_number: this.watBegin,
          end_number: this.watEnd,
          quantity: this.watQty,
          total: this.watTotal,
        },
        internet: {
          quantity: 1,
          total: this.intTotal,
          unit_price: this.intUnit,
        },
        parking_fee: {
          quantity: this.pafQty,
          total: this.pafTotal,
          unit_price: this.pafUnit,
        },
        service: {
          quantity: 1,
          total: this.serTotal,
          unit_price: this.serUnit,
        },
      };
      this.$store.dispatch('invoice/setInputForm', {roomNumber: parseInt(this.roomNumber), form: form});
    },
  },
};
</script>

<style lang="scss" scoped>
  td {
    position: relative;
    height: 45px;
    vertical-align: middle;
  }
  td input {
    text-align: center;
    position: absolute;
    display: block;
    top:0;
    left:0;
    height: 100%;
    width: 100%;
    border: none;
  }
  .input_border{
    border: 1px solid #3c88f0;
  }
</style>
