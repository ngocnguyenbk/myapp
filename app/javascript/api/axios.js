import axios from 'axios';

axios.interceptors.request.use(function(config) {
  config.url = `/${locale}${config.url}`;
  return config;
}, function(error) {
  return Promise.reject(error);
});

export default axios;
