// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start();
require('@rails/activestorage').start();
require('channels');
window.numeral = require('numeral');
window.domtoimage = require('dom-to-image');

import 'bootstrap';
import '../stylesheets/application.scss';
import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';
import 'bootstrap-fileinput/js/fileinput.min.js';
import 'bootstrap-fileinput/css/fileinput.min.css';
import FlashMessage from '@smartweb/vue-flash-message';

import Vue from 'vue';
import VueI18n from 'vue-i18n';
import store from '../store';
import Users from '../user.vue';
import NewUser from '../newUser.vue';
import Floors from '../floor.vue';
import Contracts from '../contract.vue';
import Invoices from '../invoice.vue';
import BatchCreateNewInvoices from '../batchCreateNewInvoice.vue';
import PrintInvoice from '../printInvoice.vue';
import NewInvoice from '../newInvoice.vue';

Vue.use(FlashMessage);
Vue.use(VueI18n);

Vue.filter('formatNumber', function(value) {
  return numeral(value).format('0,0');
});

document.addEventListener('DOMContentLoaded', () => {
  const elementUser = document.getElementById('userApp');
  const elementNewUser = document.getElementById('newUserApp');
  const elementFloor = document.getElementById('floorApp');
  const elementContract = document.getElementById('contractApp');
  const elementInvoice = document.getElementById('invoiceApp');
  const elementBatchCreateNewInvoiceApp = document.getElementById('batchCreateNewInvoiceApp');
  const elementprintInvoiceApp = document.getElementById('printInvoiceApp');
  const elementNewInvoice = document.getElementById('newInvoiceApp');
  const i18n = new VueI18n({
    locale: locale,
    messages: loadLocaleMessages(),
  });

  if (elementUser != null) {
    const userApp = new Vue({
      el: '#userApp',
      store,
      i18n,
      render: (h) => h(Users, {}),
    });
  }

  if (elementNewUser != null) {
    const newUserApp = new Vue({
      el: '#newUserApp',
      store,
      i18n,
      render: (h) => h(NewUser, {}),
    });
  }

  if (elementFloor != null) {
    const floorApp = new Vue({
      el: '#floorApp',
      store,
      i18n,
      render: (h) => h(Floors, {}),
    });
  }

  if (elementContract != null) {
    const contractApp = new Vue({
      el: '#contractApp',
      store,
      i18n,
      render: (h) => h(Contracts, {}),
    });
  }

  if (elementBatchCreateNewInvoiceApp != null) {
    const batchCreateNewInvoiceApp = new Vue({
      el: '#batchCreateNewInvoiceApp',
      store,
      i18n,
      render: (h) => h(BatchCreateNewInvoices, {}),
    });
  }

  if (elementInvoice != null) {
    const invoiceApp = new Vue({
      el: '#invoiceApp',
      store,
      i18n,
      render: (h) => h(Invoices, {}),
    });
  }

  if (elementprintInvoiceApp != null) {
    const printInvoiceApp = new Vue({
      el: '#printInvoiceApp',
      store,
      i18n,
      render: (h) => h(PrintInvoice, {}),
    });
  }

  if (elementNewInvoice != null) {
    const newInvoiceApp = new Vue({
      el: '#newInvoiceApp',
      store,
      i18n,
      render: (h) => h(NewInvoice, {}),
    });
  }
});

function loadLocaleMessages() {
  return require(`../locales/modules/${locale}`).default;
}

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
