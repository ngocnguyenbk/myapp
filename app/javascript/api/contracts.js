import axios from './axios.js'

export default {
  loadWithCondition (params, cb) {
    axios.get('/contracts.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  loadUsers ({}, cb) {
    axios.get('/api/contracts/users.json', {})
    .then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  loadRooms ({}, cb) {
    axios.get('/api/contracts/rooms.json', {})
    .then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  createContract (params, cb) {
    axios.post('/contracts.json',
      { contract: params },
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  loadDetailContract (id, cb) {
    axios.get(`/contracts/${id}.json`, {}
    ).then(function(response) {
      cb(response.data)
    })['catch'](function(error) {
      console.log(error)
    })
  }
}
