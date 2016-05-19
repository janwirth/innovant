tableify = require 'tableify'
shortid = require 'shortid'

# dummy innovation page data
#

defaultTable = [
    hello: 'world'
    you: 'know'
  ,
    hello: 'world'
]

html = tableify defaultTable
editableHtml = html.substring(0,6) + ' contenteditable ' + html.substring(6)
console.log editableHtml

module.exports = ->
  _id: shortid.generate()
  name: 'My new Product'
  modules: [
      type: 'hero'
      content:
        Heading: 'Make a dent in the universe',
        Text: 'Our revolutionary concept is just great'
        Image: 'https://images.unsplash.com/photo-1459664018906-085c36f472af?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=0790a8686cb07ac8851066ef544f1082'
      analytics:
        active: true
        question:
          text: 'Do you find this product visually appealing?'
          explanation: 'Rate from zero to ten'
        scale:
          type: 'analog'
          labelLow: 'ugly'
          labelHigh: 'attractive'
    ,
      type: 'table'
      content:
        Heading: 'Compare our features',
        Table: editableHtml
      analytics:
        active: false
  ]
