# Contenteditable directive

module.exports =
  twoWay: true
  params: ['mode']
  update: (newValue, oldValue) ->
    @medium = new Medium
      element: @el
      mode: Medium.richMode
    setTimeout => @medium.value newValue
      , 1000
    @medium.element.addEventListener 'keyup', =>
      @set @medium.value()
