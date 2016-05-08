Vue       = require 'vue'
VueRouter = require 'vue-router'

Vue.use VueRouter

router    = new VueRouter
  root: '/'

editor    = require './editor.vue'
overview  = require './overview.vue'

router.map
  '/edit':
    component: editor
  '/':
    component: overview

App = Vue.extend()

router.start(App, '#app')
