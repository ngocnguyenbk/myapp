const {environment} = require('@rails/webpacker');
const {VueLoaderPlugin} = require('vue-loader');
const sass = require('./loaders/sass');
const vue = require('./loaders/vue');

const webpack = require('webpack');

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
}));

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('sass', sass);
environment.loaders.prepend('vue', vue);
module.exports = environment;
