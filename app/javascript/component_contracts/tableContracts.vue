<template>
  <table class="table table-multi-body table-bordered">
    <thead class="table-header">
      <tr class="table-head text-center">
        <td class="w-120px align-middle">{{ $t('contract.contract_id') }}</td>
        <td class="w-200px align-middle">{{ $t('contract.holder_name') }}</td>
        <td class="w-150px align-middle">{{ $t('contract.room_number') }}</td>
        <td class= "align-middle">{{ $t('contract.room_price') }}</td>
        <td class="w-200px align-middle">{{ $t('contract.deposited_money') }}</td>
        <td class="w-120px align-middle">{{ $t('contract.start_date') }}</td>
        <td class="w-120px align-middle">{{ $t('contract.end_date') }}</td>
        <td class="w-100px align-middle">{{ $t('contract.extend') }}</td>
        <td class="w-100px align-middle">{{ $t('contract.details') }}</td>
        <td class="w-100px align-middle">{{ $t('contract.terminate') }}</td>
        <td class="w-100px align-middle">{{ $t('contract.status') }}</td>
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
