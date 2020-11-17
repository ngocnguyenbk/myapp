<template>
  <tbody :class="background_row_contract">
    <tr>
      <td>{{contract.id}}</td>
      <td>{{contract.holder_name}}</td>
      <td>{{contract.room_number}}</td>
      <td>{{contract.room_price | formatNumber}}</td>
      <td>{{contract.deposited_money | formatNumber}}</td>
      <td>{{contract.start_date}}</td>
      <td>{{contract.end_date}}</td>
    </tr>
  </tbody>
</template>

<script>
export default {
  props: {
    contract: {
      type: Object,
      required: true
    },
    odd: {
      type: Boolean,
      required: true
    }
  },
  computed: {
    background_row_contract: function() {
      return this.odd ? 'odd-bg' : 'even-bg'
    }
  }
}
</script>
