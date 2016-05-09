# Contenteditable directive
Medium = require 'medium.js'

module.exports =
  twoWay: true
  params: ['mode']
  update: (newValue, oldValue) ->
    @medium = new Medium
      element: @el
      mode: Medium.inlineMode
    @medium.value newValue
    @medium.element.addEventListener 'keyup', =>
      @set @medium.value()
