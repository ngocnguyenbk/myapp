import axios from './axios.js';

export default {
  loadInvoiceForm(params, cb) {
    const payload = {};
    payload['invoices[month]'] = params.month;
    axios.get('/batch_create/invoices/new.json', {
      params: payload,
    }).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  async createInvoices({params, month}, cb) {
    await axios.post('/batch_create/invoices.json',
        {invoices: {multi_invoices: params, month: month}},
        {headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}},
    ).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  loadWithCondition(params, cb) {
    axios.get('/invoices.json', {
      params: params,
    }).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  loadRooms(params, cb) {
    axios.get('/api/invoices/rooms.json', {
      params: params,
    }).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  async createInvoice(params, cb) {
    await axios.post('/invoices.json',
        {invoices: params},
        {headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}},
    ).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  getResourceInfo(params, cb) {
    const payload = {};
    payload['invoice[room_id]'] = params.room_id;
    payload['invoice[month]'] = params.month;
    axios.get(`/invoices/new.json`, {
      params: payload,
    }).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  loadDetailInvoice(id, cb) {
    axios.get(`/invoices/${id}.json`, {})
        .then(function(response) {
          cb(response.data);
        }).catch(function(error) {
          console.log(error.response);
        });
  },
  async updateInvoice(params, cb) {
    await axios.patch(`/invoices/${params.id}.json`,
        {invoices: params},
        {headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}},
    ).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  deleteInvoice(params, cb) {
    axios.delete(`/invoices/${params.id}.json`,
        {headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}},
    ).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
};
