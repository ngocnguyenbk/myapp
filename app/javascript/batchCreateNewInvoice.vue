<template>
  <div id="app">
    <FlashMessage :position="'right top'" />
    <NewInvoices />
  </div>
</template>

<script>
import NewInvoices from './component_invoices/batch_create/newInvoices';

export default {
  components: {
    NewInvoices,
  },
};
</script>
