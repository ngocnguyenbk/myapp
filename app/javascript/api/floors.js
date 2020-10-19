import axios from './axios.js'

export default {
  loadWithCondition (params, cb) {
    axios.get('/floors.json', {
      params: params
    }).then(function(response) {
      cb(response.data)
    }).catch(function (error) {
      console.log(error.response)
    });
  }
}
