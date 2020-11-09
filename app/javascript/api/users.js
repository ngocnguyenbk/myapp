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
    axios.get('/api/floors/users.json', {
      params: {
        room_id: params.room_id
      }
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  async updateUser (params, cb) {
    await axios.patch(`/users/${params.id}.json`,
      { user: params },
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  },
  deleteUser (params, cb) {
    axios.delete(`/users/${params.id}.json`,
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
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
  },
  createUsers (params, cb) {
    axios.post('/users.json',
      { multi_users: { user_attributes: params }},
      { headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}}
    ).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  }
}
