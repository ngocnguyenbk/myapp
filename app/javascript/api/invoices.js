import axios from './axios.js'

export default {
  loadInvoiceForm (params, cb) {
    axios.get('/batch_create/invoices/new.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  createInvoices (params, cb) {
    axios.post('/batch_create/invoices.json',
      { invoices: { multi_invoices: params } },
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  loadWithCondition (params, cb) {
    axios.get('/invoices.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function(error) {
      console.log(error.response)
    })
  },
  loadRooms (params, cb) {
    axios.get('/api/invoices/rooms.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  async createInvoice (params, cb) {
    await axios.post('/invoices.json',
      { invoices: params },
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  loadOneRoom (params, cb) {
    axios.get(`/api/invoices/rooms/${params.id}.json`, {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  getResourcePrice(params, cb) {
    axios.get(`/invoices/new.json`, {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    })
  },
  loadDetailInvoice(id, cb) {
    axios.get(`/invoices/${id}.json`, {})
    .then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    })
  },
  async updateInvoice (params, cb) {
    await axios.patch(`/invoices/${params.id}.json`,
      { invoices: params },
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  deleteInvoice (params, cb) {
    axios.delete(`/invoices/${params.id}.json`,
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    })
  }
}
