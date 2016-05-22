Vue       = require 'vue'
VueRouter = require 'vue-router'

window.Medium = require './Medium.js'
window.rangy = require 'rangy'
window.Undo = require 'undo.js'

console.log rangy
console.log window

Vue.use VueRouter

router    = new VueRouter()

editor    = require './components/editor.vue'
overview  = require './components/overview.vue'

router.map
  '/edit/:_id/:innovation_slug':
    component: editor
  '/':
    component: overview

App = Vue.extend()

router.start(App, '#app')
