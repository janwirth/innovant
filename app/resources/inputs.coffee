module.exports =
  range: (label = 'Pol A', labelHigh = 'Pol B') ->
    type: 'range'
    label: label
    labelHigh: labelHigh
    name: 'Intervallfeld'

  textarea: (label = 'Feldspezifische Frage') ->
    label: label
    type: 'textarea'
    name: 'Textfeld'
