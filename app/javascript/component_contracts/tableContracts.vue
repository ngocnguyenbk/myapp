<template>
  <table class="table table-multi-body table-bordered">
    <thead class="table-header">
      <tr class="table-head">
        <td class="w-120px">Contract id</td>
        <td class="w-200px">Holder name</td>
        <td class="w-150px">Room number</td>
        <td>Room price</td>
        <td class="w-200px">Deposited money</td>
        <td class="w-120px">Start date</td>
        <td class="w-120px">End date</td>
        <td class="w-100px">Extend</td>
        <td class="w-100px">Details</td>
        <td class="w-100px">Terminate</td>
        <td class="w-100px">Status</td>
      </tr>
    </thead>
    <RowContract :contract="contract" :odd="(index % 2) != 0" v-for="(contract, index) in contracts" :key="index" />
    <DetailContract ref="detail_contract"/>
    <TerminateContract />
    <ExtendContract />
  </table>
</template>

<script>
import RowContract from './rowContract'
import DetailContract from './detailContract'
import TerminateContract from './terminateContract'
import ExtendContract from './extendContract'

export default {
  components: {
    RowContract,
    DetailContract,
    TerminateContract,
    ExtendContract
  },
  props: {
    contracts: {
      type: Array,
      required: true
    }
  }
}
</script>
