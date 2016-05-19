shortid = require 'shortid'
jade = require 'jade'

# dummy innovation page data
#
jadeTable =
"""
table(contenteditable='true')
  thead
    td Feature
    th Basic
    th Premium
    th Pro
  tr
    td Unlimited Streaming
    td X
    td X
    td X
  tr
    td Downloads
    td
    td X
    td X
  tr
    td High Quality Streaming
    td
    td X
    td X
  tr
    td Remixes
    td
    td
    td X
"""
tableHtml = jade.render jadeTable


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
          text: 'How attractive do you find this design?'
          explanation: 'Please do not consider the color scheme.'
        inputs: [
            type: 'range'
            label: 'ugly'
            labelHigh: 'attractive'
          ,
            type: 'textarea'
          ]
    ,
      type: 'table'
      content:
        Heading: 'Compare our features',
        Table: tableHtml
      analytics:
        active: false
  ]
