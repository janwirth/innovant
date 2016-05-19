# Contenteditable directive
module.exports =
  twoWay: true
  params: ['mode']
  update: (newValue, oldValue) ->
    @medium = new Medium
      element: @el
      mode: Medium.richMode
    @medium.value newValue
    @medium.element.addEventListener 'keyup', =>
      @set @medium.value()
