Vue = require 'vue'

# dummy innovation page data
currentInnovation =
  modules: [
    type: 'hero'
    content:
      Title: 'Hello World',
      Text: 'Der neue Staubsaugo'
      Image: 'https://images.unsplash.com/photo-1459664018906-085c36f472af?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=0790a8686cb07ac8851066ef544f1082'
    analytics:
      active: true
      question:
        text: 'Do you find this product visually appealing?'
        explanation: 'Rate from zero to ten'
      scale:
        type: 'analog'
        labelLow: 'schlecht'
        labelHigh: 'gut'
  ]

# Initialize view engine
app = new Vue
  el: '#app'
  data:
    innovation:
      versions: [currentInnovation]
