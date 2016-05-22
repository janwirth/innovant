Vue.use VueRouter
Vue.use VueFire

router    = new VueRouter()

editor    = require './components/editor.vue'
overview  = require './components/overview.vue'

router.map
  '/edit/:innovation_slug':
    component: editor
  '/':
    component: overview

App = Vue.extend()

router.start(App, '#app')
