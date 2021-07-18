import {forEach, replace} from 'lodash';

export default {
  methods: {
    convert_params(params) {
      let newParams = {};
      forEach(params, function(value, key) {
        const newKey = key.match(/^q\[(\w+)\]$/)[1];
        newParams[newKey] = value;
      });

      return newParams;
    },
  },
};
