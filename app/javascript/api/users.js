import axios from './axios.js'

export default {
  loadWithCondition (params, cb) {
    axios.get('/users.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  loadUsers (params, cb) {
    axios.get('/api/users.json', {
      params: {
        room_id: params.room_id
      }
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  loadRooms (params, cb) {
    axios.get('/api/users/rooms.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  }
}
