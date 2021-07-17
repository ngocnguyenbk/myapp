<template>
  <table class="table table-striped table-bordered">
    <thead class="table-header">
      <tr class="table-head text-center">
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.contract_id') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.holder_name') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.room_number') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.room_price') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.deposited_money') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.start_date') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.end_date') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.extend') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.details') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.terminate') }}
        </td>
        <td
          scope="col"
          class="align-middle"
        >
          {{ $t('contract.status') }}
        </td>
      </tr>
    </thead>
    <tbody>
      <RowContract
        v-for="(contract, index) in contracts"
        :key="index"
        :contract="contract"
      />
    </tbody>
    <DetailContract ref="detail_contract" />
    <TerminateContract />
    <ExtendContract />
  </table>
</template>

<script>
import RowContract from './rowContract';
import DetailContract from './detailContract';
import TerminateContract from './terminateContract';
import ExtendContract from './extendContract';

export default {
  components: {
    RowContract,
    DetailContract,
    TerminateContract,
    ExtendContract,
  },
  props: {
    contracts: {
      type: Array,
      required: true,
    },
  },
};
</script>
