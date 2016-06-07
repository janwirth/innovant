Vue.use VueRouter
Vue.use VueDnd

router    = new VueRouter()

header    = require './components/header.vue'
overview  = require './components/overview.vue'
editor    = require './components/editor.vue'
viewer    = require './components/viewer.vue'

Vue.component 'headbar', header

router.map
  '/':
    component: overview
    title: 'Übersicht'
  '/edit/:ID/:innovation_slug':
    title: 'Bearbeiten'
    component: editor
  '/:ID/:innovation_slug':
    component: viewer

App = Vue.extend()



router.start(App, '#app')
