<template>
  <table class="table table-multi-body table-bordered">
    <thead class="table-header">
      <tr class="table-head">
        <td class="w-120px">{{ $t('contract.contract_id') }}</td>
        <td class="w-200px">{{ $t('contract.holder_name') }}</td>
        <td class="w-150px">{{ $t('contract.room_number') }}</td>
        <td>{{ $t('contract.room_price') }}</td>
        <td class="w-200px">{{ $t('contract.deposited_money') }}</td>
        <td class="w-120px">{{ $t('contract.start_date') }}</td>
        <td class="w-120px">{{ $t('contract.end_date') }}</td>
        <td class="w-100px">{{ $t('contract.extend') }}</td>
        <td class="w-100px">{{ $t('contract.details') }}</td>
        <td class="w-100px">{{ $t('contract.terminate') }}</td>
        <td class="w-100px">{{ $t('contract.status') }}</td>
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
