Vue = require 'vue'

# Initialize view engine
vm = new Vue
  el: '#app'
  components:
    editor: require './editor.vue'
