import axios from './axios.js'

export default {
  loadInvoiceForm (params, cb) {
    axios.get('/invoices/new.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  createInvoices (params, cb) {
    axios.post('/invoices.json',
      { invoices: { multi_invoices: params } },
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  }
}
