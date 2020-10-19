// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap'
import Vue from 'vue'
import store from '../store'
import Users from '../user.vue'
import Floors from '../floor.vue'

document.addEventListener('DOMContentLoaded', () => {
  const elementUser = document.getElementById('userApp')
  const elementFloor = document.getElementById('floorApp')

  if(elementUser != null) {
    var userApp = new Vue({
      el: '#userApp',
      store,
      render: h => h(Users, {})
    })
  }

  if(elementFloor != null) {
    var floorApp = new Vue({
      el: '#floorApp',
      store,
      render: h => h(Floors, {})
    })
  }
})

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
