import axios from './axios.js';

export default {
  loadWithCondition(params, cb) {
    axios.get('/floors.json', {
      params: params,
    }).then(function(response) {
      cb(response.data);
    }).catch(function(error) {
      console.log(error.response);
    });
  },
  async updateRoom(params, cb) {
    await axios.patch(`/api/floors/rooms/${params.id}.json`,
        {room: params},
        {headers: {'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')}},
    ).then(function(response) {
      cb(response.data);
    })['catch'](function(error) {
      console.log(error);
    });
  },
};
