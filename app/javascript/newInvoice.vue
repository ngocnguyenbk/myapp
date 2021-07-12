<template>
  <div id="app">
    <FlashMessage :position="'right top'"></FlashMessage>
    <NewInvoices />
  </div>
</template>

<script>
import NewInvoices from './component_invoices/newInvoices';

export default {
  components: {
    NewInvoices,
  },
  created: function() {
    this.$store.dispatch('invoice/getRooms');
  },
};
</script>
