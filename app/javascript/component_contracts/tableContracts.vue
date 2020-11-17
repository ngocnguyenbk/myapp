<template>
  <table class="table table-multi-body table-bordered">
    <thead class="table-header">
      <tr class="table-head">
        <td class="w-200px">Contract id</td>
        <td class="w-200px">Holder name</td>
        <td class="w-200px">Room number</td>
        <td>Room price</td>
        <td class="w-200px">Deposited money</td>
        <td class="w-200px">Start date</td>
        <td class="w-200px">End date</td>
        <td class="w-100px">Details</td>
      </tr>
    </thead>
    <RowContract :contract="contract" :odd="(index % 2) != 0" v-for="(contract, index) in contracts" :key="index" />
    <DetailContract ref="detail_contract"/>
  </table>
</template>

<script>
import RowContract from './rowContract'
import DetailContract from './detailContract'

export default {
  components: {
    RowContract,
    DetailContract
  },
  props: {
    contracts: {
      type: Array,
      required: true
    }
  }
}
</script>
