<template>
  <table class="table table-multi-body table-bordered">
    <thead class="table-header">
      <tr class="table-head">
        <td class="w-200px">CONTRACT ID</td>
        <td class="w-200px">HOLDER NAME</td>
        <td class="w-200px">ROOM NUMBER</td>
        <td>ROOM PRICE</td>
        <td class="w-200px">DEPOSITED MONEY</td>
        <td class="w-200px">START DATE</td>
        <td class="w-200px">END DATE</td>
      </tr>
    </thead>
    <RowContract :contract="contract" :odd="(index % 2) != 0" v-for="(contract, index) in contracts" :key="index" />
  </table>
</template>

<script>
import RowContract from './rowContract'

export default {
  components: {
    RowContract
  },
  props: {
    contracts: {
      type: Array,
      required: true
    }
  }
}
</script>
