<template>
  <tr
    class="text-center"
    @dblclick="dbclickShowContract"
  >
    <td>{{ contract.id }}</td>
    <td>{{ contract.holder_name }}</td>
    <td>{{ contract.room_number }}</td>
    <td>{{ contract.room_price | formatNumber }}</td>
    <td>{{ contract.deposited_money | formatNumber }}</td>
    <td>{{ contract.start_date }}</td>
    <td>{{ contract.end_date }}</td>
    <td class="text-center">
      <i
        :class="['fas fa-expand-arrows-alt text-primary pointer', contract.active ? 'pointer' : 'pointer_disable']"
        data-toggle="modal"
        data-target="#extendContract"
        @click="getDetailContract"
      />
    </td>
    <td class="text-center">
      <i
        class="far fa-eye text-primary pointer"
        data-toggle="modal"
        data-target="#detailContract"
        @click="getDetailContract"
      />
    </td>
    <td class="text-center">
      <i
        :class="['far fa-stop-circle text-danger', contract.active ? 'pointer' : 'pointer_disable']"
        data-toggle="modal"
        data-target="#terminateContract"
        @click="getDetailContract"
      />
    </td>
    <td class="text-center">
      <div :class="['dot dot-sm ml-auto', statusContract]" />
    </td>
  </tr>
</template>

<script>
export default {
  props: {
    contract: {
      type: Object,
      required: true,
    },
  },
  computed: {
    statusContract: function() {
      return this.contract.active ? 'active' : 'inactive';
    },
  },
  methods: {
    getDetailContract: function() {
      this.$store.dispatch('contract/getDetailContract', this.contract);
    },
    dbclickShowContract: function() {
      this.getDetailContract();
      $('#detailContract').modal('toggle');
    },
  },
};
</script>

<style lang="scss" scoped>
  .pointer {
    cursor: pointer;
  }

  .pointer_disable {
    pointer-events: none;
    color: gray !important;
  }
</style>
