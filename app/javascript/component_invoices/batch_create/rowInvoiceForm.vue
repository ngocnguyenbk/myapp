<template>
  <tbody :class="background_row">
    <tr class="table-head text-center" v-if="is_empty">
      <td>
        <div class="form-check">
          <input type="checkbox" class="form-check-input" disabled>
          <label class="form-check-label"></label>
        </div>
      </td>
      <td>{{ room_number }}</td>
      <td v-for="index in sameCell" :key="index"></td>
      <td>{{ $t('invoice.not_contract') }}</td>
    </tr>

    <tr class="table-head text-center js-input" v-else>
      <td>
        <div class="form-check">
          <input type="checkbox" class="form-check-input" :id="`check-${room_number}`" v-model="checked">
          <label class="form-check-label" :for="`check-${room_number}`"></label>
        </div>
      </td>
      <td><input readonly :id="room_number" v-model="roomNumber"></td>
      <td><input readonly :id="`deposited_money_${room_number}`" :value="depMoney.toLocaleString()"></td>
      <td><input type="text" :id="`room_price_${room_number}`" class="input_border" v-model="roomPrice"></td>
      <td><input type="text" :id="`electric_begin_number_${room_number}`" class="input_border" v-model="eleBegin"></td>
      <td><input type="text" :id="`electric_end_number_${room_number}`" class="input_border" v-model="eleEnd"></td>
      <td><input readonly :id="`electric_quantity_${room_number}`" :value="eleQty.toLocaleString()"></td>
      <td><input readonly :id="`electric_total_${room_number}`" :value="eleTotal.toLocaleString()"></td>
      <td><input type="text" :id="`water_begin_number_${room_number}`" class="input_border" v-model="watBegin"></td>
      <td><input type="text" :id="`water_end_number_${room_number}`" class="input_border" v-model="watEnd"></td>
      <td><input readonly :id="`water_quantity_${room_number}`" :value="watQty.toLocaleString()"></td>
      <td><input readonly :id="`water_total_${room_number}`" :value="watTotal.toLocaleString()"></td>
      <td><input type="text" :id="`internet_total_${room_number}`" class="input_border" v-model="intTotal"></td>
      <td><input readonly :id="`parking_fee_total_${room_number}`" :value="pafTotal.toLocaleString()"></td>
      <td><input type="text" :id="`parking_fee_quantity_${room_number}`" class="input_border" v-model="pafQty"></td>
      <td><input type="text" :id="`service_total_${room_number}`" class="input_border" v-model="serTotal"></td>
      <td><input readonly :id="`total_${room_number}`" :value="total.toLocaleString()"></td>
      <td><input type="text" :id="`reduce_${room_number}`" class="input_border" v-model="invReduce"></td>
      <td>{{ item.extend_data.holder_name }}</td>
      <td></td>
    </tr>
  </tbody>
</template>

<script>
export default {
  props: {
    item: {
      type: Object,
      required: true
    },
    room_number: {
      type: String,
      required: true
    },
    month: {
      type: Date
    },
    checkAll: {
      type: Boolean,
      required: true,
    }
  },
  data: function() {
    if (Object.keys(this.item).length == 0) {
      return {
        sameCell: 17
      }
    } else {
      return {
        roomNumber: this.room_number,
        depMoney: this.item.contract.deposited_money,
        roomPrice: this.item.contract.room_price,
        eleBegin: this.item.electric.begin_number,
        eleEnd: this.item.electric.end_number,
        eleQty: this.item.electric.quantity,
        eleTotal: this.item.electric.total,
        watBegin: this.item.water.begin_number,
        watEnd: this.item.water.end_number,
        watQty: this.item.water.quantity,
        watTotal: this.item.water.total,
        intTotal: this.item.internet.total,
        pafTotal: this.item.parking_fee.total,
        pafQty: this.item.parking_fee.quantity,
        serTotal: this.item.service.total,
        invReduce: this.item.invoice.reduce,
        total: 0,
        checked: false,
      }
    }
  },
  computed: {
    background_row: function() {
      return this.is_empty ? 'odd-bg' : 'even-bg'
    },
    is_empty: function() {
      return Object.keys(this.item).length == 0
    }
  },
  watch: {
    eleBegin: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      let qty = this.eleEnd - parseInt(newVal)
      qty = qty > 0 ? qty : 0
      this.eleBegin = parseInt(newVal)
      this.eleQty = qty
      this.eleTotal = this.eleQty * this.item.electric.unit_price
      this.calculateTotal()
    },
    eleEnd: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      let qty = parseInt(newVal) - this.eleBegin
      qty = qty > 0 ? qty : 0
      this.eleEnd = parseInt(newVal)
      this.eleQty = qty
      this.eleTotal = this.eleQty * this.item.electric.unit_price
      this.calculateTotal()
    },
    watBegin: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      let qty = this.watEnd - parseInt(newVal)
      qty = qty > 0 ? qty : 0
      this.watBegin = parseInt(newVal)
      this.watQty = qty
      this.watTotal = this.watQty * this.item.water.unit_price
      this.calculateTotal()
    },
    watEnd: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      let qty = parseInt(newVal) - this.watBegin
      qty = qty > 0 ? qty : 0
      this.watEnd = parseInt(newVal)
      this.watQty = qty
      this.watTotal = this.watQty * this.item.water.unit_price
      this.calculateTotal()
    },
    pafQty: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      this.pafQty = parseInt(newVal)
      this.pafTotal = parseInt(newVal) * this.item.parking_fee.unit_price
      this.calculateTotal()
    },
    roomPrice: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      this.roomPrice = parseInt(newVal)
      this.calculateTotal()
    },
    intTotal: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      this.intTotal = parseInt(newVal)
      this.calculateTotal()
    },
    serTotal: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      this.serTotal = parseInt(newVal)
      this.calculateTotal()
    },
    invReduce: function(val) {
      let newVal = this.isNumeric(val) ? val : 0
      this.invReduce = parseInt(newVal)
      this.calculateTotal()
    },
    checkAll(val) {
      this.checked = val
    },
    checked(val) {
      this.$emit('checked', { check: val, roomNumber: this.roomNumber })
    },
  },
  methods: {
    findClosestTr: function(tBody, arrow) {
      let rowContinue = null
      if (arrow === 'up') {
        rowContinue = tBody.prev('tbody')
      } else if (arrow === 'down') {
        rowContinue = tBody.next('tbody')
      }
      if (rowContinue.length == 0) return
      if (rowContinue.find('input').length <= 1) {
        return this.findClosestTr(rowContinue, arrow)
      } else {
        return rowContinue.find('tr')
      }
    },
    calculateTotal: function() {
      this.total = this.roomPrice + this.eleTotal + this.watTotal + this.intTotal + this.pafTotal + this.serTotal - this.invReduce
      this.buildForm()
    },
    isNumeric: function (val) {
      return !isNaN(parseFloat(val)) && isFinite(val)
    },
    buildForm: function() {
      let form = {
        invoice: {
          date_export: this.month,
          reduce: this.invReduce,
          total: this.total,
          contract_id: this.item.contract.contract_id
        },
        electric: {
          begin_number: this.eleBegin,
          end_number: this.eleEnd,
          quantity: this.eleQty,
          total: this.eleTotal
        },
        water: {
          begin_number: this.watBegin,
          end_number: this.watEnd,
          quantity: this.watQty,
          total: this.watTotal
        },
        internet: {
          quantity: this.item.internet.quantity,
          total: this.intTotal,
          unit_price: this.item.internet.unit_price
        },
        parking_fee: {
          quantity: this.pafQty,
          total: this.pafTotal,
          unit_price: this.item.parking_fee.unit_price
        },
        service: {
          quantity: this.item.service.quantity,
          total: this.serTotal,
          unit_price: this.item.service.unit_price
        }
      }
      this.$store.dispatch('invoice/setInputForm', { roomNumber: parseInt(this.roomNumber), form: form })
    }
  },
  mounted: function() {
    if (!this.is_empty) {
      this.buildForm()
    }
    let self = this
    $('.js-input').find(':input').on('click', function(e){
      $(this).select()
    })

    $('.js-input').find(':input').on('keyup', function(e){
      let arrow = { left: 37, up: 38, right: 39, down: 40 }
      if ($.inArray(e.keyCode, [arrow.left, arrow.up, arrow.right, arrow.down]) < 0) return

      let td = $(this).closest('td')
      let moveTo = null
      switch(e.keyCode) {
        case arrow.left:
          moveTo = td.prev('td')
          break
        case arrow.right:
          moveTo = td.next('td')
          break
        case arrow.up:
        case arrow.down:
          let tBody = td.closest('tbody')
          let pos = td[0].cellIndex
          let moveToRow = null

          if (e.keyCode == arrow.down) {
            moveToRow = self.findClosestTr(tBody, 'down')
          } else if (e.keyCode == arrow.up) {
            moveToRow = self.findClosestTr(tBody, 'up')
          }
          if (typeof moveToRow === 'undefined') return
          if (moveToRow.length) {
            moveTo = $(moveToRow[0].cells[pos])
          }
          break
      }

      if (moveTo && moveTo.length) {
        e.preventDefault()
        moveTo.find('input').each(function (i, input) {
          input.focus()
          input.select()
        })
      }
    })

    $('.js-input').find(':input').on('input', (e) => {
      this.$emit('input')
    })
  }
}
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
